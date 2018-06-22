import UIKit

class Touch3DViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .yellow
        
        let button = UIButton()
        button.backgroundColor = .red
        button.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        button.center = view.center
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc private func buttonAction() {
        dismiss(animated: true, completion: nil)
    }
    
    override var previewActionItems: [UIPreviewActionItem] {
        let cancelItem = UIPreviewAction(title: "取消", style: UIPreviewActionStyle.destructive) { (action, viewController) in
            
        }
        let certainItem = UIPreviewAction(title: "确定", style: UIPreviewActionStyle.default) { (action, viewController) in
            
        }
        return [cancelItem, certainItem]
    }
}
