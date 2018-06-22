import UIKit

class OtherTouch3DViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        
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
        let cancelItem = UIPreviewAction(title: "取消", style: .destructive) { (action, viewController) in
            
        }
        let certainItem = UIPreviewAction(title: "确定", style: .default) { (action, viewController) in
            
        }
        
        let groupItem = UIPreviewActionGroup(title: "汇总", style: .default, actions: [cancelItem, certainItem])
        
        return [groupItem]
    }
}
