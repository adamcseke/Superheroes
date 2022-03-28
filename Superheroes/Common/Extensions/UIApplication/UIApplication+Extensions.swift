import UIKit

extension UIApplication {
    public class var safeAreaInsets: UIEdgeInsets {
        let window = UIApplication.shared.windows.first(where: \.isKeyWindow)
        return window?.safeAreaInsets ?? .zero
    }
}
