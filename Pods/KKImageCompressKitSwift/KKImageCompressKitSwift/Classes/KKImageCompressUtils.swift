import Foundation
import UIKit

public final class KKImageCompressUtils {
    public struct compress_config {
        public let min_bytes: Int
        public let max_bytes: Int
        public let max_width: CGFloat
        public let max_height: CGFloat
        public let binary_search_iterations: Int
        public let fallback_scale_step: CGFloat
        public let fallback_min_scale: CGFloat
        public let fallback_loop_quality: CGFloat
        public let fallback_final_quality: CGFloat

        public init(
            min_bytes: Int = 200 * 1000,
            max_bytes: Int = 600 * 1000,
            max_width: CGFloat = 6000,
            max_height: CGFloat = 6000,
            binary_search_iterations: Int = 20,
            fallback_scale_step: CGFloat = 0.9,
            fallback_min_scale: CGFloat = 0.1,
            fallback_loop_quality: CGFloat = 0.8,
            fallback_final_quality: CGFloat = 0.7
        ) {
            self.min_bytes = min_bytes
            self.max_bytes = max_bytes
            self.max_width = max_width
            self.max_height = max_height
            self.binary_search_iterations = binary_search_iterations
            self.fallback_scale_step = fallback_scale_step
            self.fallback_min_scale = fallback_min_scale
            self.fallback_loop_quality = fallback_loop_quality
            self.fallback_final_quality = fallback_final_quality
        }
    }

    public static func compress_image_data(
        _ image: UIImage,
        config: compress_config = compress_config()
    ) -> Data? {
        let resized_image = resize_image_if_needed(
            image,
            max_width: config.max_width,
            max_height: config.max_height
        )

        if let hit_data = compress_by_quality_binary_search(
            resized_image,
            min_bytes: config.min_bytes,
            max_bytes: config.max_bytes,
            max_iterations: config.binary_search_iterations
        ) {
            return hit_data
        }

        return fallback_reduce_size(
            resized_image,
            min_bytes: config.min_bytes,
            max_bytes: config.max_bytes,
            scale_step: config.fallback_scale_step,
            min_scale: config.fallback_min_scale,
            loop_quality: config.fallback_loop_quality,
            final_quality: config.fallback_final_quality
        )
    }

    // MARK: - Step 1: Resize

    static func resize_image_if_needed(
        _ image: UIImage,
        max_width: CGFloat,
        max_height: CGFloat
    ) -> UIImage {
        let original_size = image.size
        let original_width = original_size.width
        let original_height = original_size.height

        guard original_width > 0, original_height > 0 else {
            return image
        }

        if original_width <= max_width, original_height <= max_height {
            return image
        }

        let aspect_ratio = original_width / original_height
        var target_width = original_width
        var target_height = original_height

        if original_width > original_height {
            target_width = min(original_width, max_width)
            target_height = target_width / aspect_ratio
            if target_height > max_height {
                target_height = max_height
                target_width = target_height * aspect_ratio
            }
        } else {
            target_height = min(original_height, max_height)
            target_width = target_height * aspect_ratio
            if target_width > max_width {
                target_width = max_width
                target_height = target_width / aspect_ratio
            }
        }

        if target_width > max_width {
            target_width = max_width
            target_height = target_width / aspect_ratio
        }
        if target_height > max_height {
            target_height = max_height
            target_width = target_height * aspect_ratio
        }

        let final_size = CGSize(width: max(1, floor(target_width)), height: max(1, floor(target_height)))
        return redraw_image(image, target_size: final_size) ?? image
    }

    // MARK: - Step 2: Binary Search by Quality

    static func compress_by_quality_binary_search(
        _ image: UIImage,
        min_bytes: Int,
        max_bytes: Int,
        max_iterations: Int
    ) -> Data? {
        var low: CGFloat = 0.0
        var high: CGFloat = 1.0

        var best_below_min_data: Data?
        var best_below_min_delta = Int.max

        for _ in 0..<max_iterations {
            let mid = (low + high) / 2.0
            guard let data = image.jpegData(compressionQuality: mid) else {
                continue
            }

            let bytes = data.count
            if bytes >= min_bytes, bytes <= max_bytes {
                return data
            }

            if bytes < min_bytes {
                let delta = min_bytes - bytes
                if delta < best_below_min_delta {
                    best_below_min_delta = delta
                    best_below_min_data = data
                }
                low = mid
            } else {
                high = mid
            }
        }

        // Spec-aligned: after max iterations, return below-min fallback candidate if exists.
        if let best_below_min_data {
            return best_below_min_data
        }
        return nil
    }

    // MARK: - Step 3: Fallback Reduce Size

    static func fallback_reduce_size(
        _ image: UIImage,
        min_bytes: Int,
        max_bytes: Int,
        scale_step: CGFloat,
        min_scale: CGFloat,
        loop_quality: CGFloat,
        final_quality: CGFloat
    ) -> Data? {
        var current_image = image
        var cumulative_scale: CGFloat = scale_step
        var closest_over_upper_data: Data?
        var closest_over_upper_delta = Int.max
        var closest_below_min_data: Data?
        var closest_below_min_delta = Int.max

        while cumulative_scale >= min_scale {
            let new_size = CGSize(
                width: max(1, floor(image.size.width * cumulative_scale)),
                height: max(1, floor(image.size.height * cumulative_scale))
            )
            if let redrawn = redraw_image(image, target_size: new_size) {
                current_image = redrawn
            }

            guard let data = current_image.jpegData(compressionQuality: loop_quality) else {
                cumulative_scale *= scale_step
                continue
            }

            let bytes = data.count
            if bytes >= min_bytes, bytes <= max_bytes {
                return data
            }

            if bytes > max_bytes {
                let delta = bytes - max_bytes
                if delta < closest_over_upper_delta {
                    closest_over_upper_delta = delta
                    closest_over_upper_data = data
                }
            } else {
                let delta = min_bytes - bytes
                if delta < closest_below_min_delta {
                    closest_below_min_delta = delta
                    closest_below_min_data = data
                }
                // Spec-aligned: stop fallback shrinking once data is no longer above upper bound.
                break
            }

            cumulative_scale *= scale_step
        }

        if let final_data = current_image.jpegData(compressionQuality: final_quality) {
            return final_data
        }

        if let closest_below_min_data {
            return closest_below_min_data
        }
        if let closest_over_upper_data {
            return closest_over_upper_data
        }
        return nil
    }

    // MARK: - Helper

    static func redraw_image(_ image: UIImage, target_size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(target_size, false, image.scale)
        image.draw(in: CGRect(origin: .zero, size: target_size))
        let resized = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resized
    }
}
