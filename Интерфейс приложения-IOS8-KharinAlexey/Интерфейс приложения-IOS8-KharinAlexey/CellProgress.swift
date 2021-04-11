

import UIKit

class CellProgress: UIView {
    
    var progressInformation: Float? {
        didSet {
            progress.progress = progressInformation!
            countProgress.text = " \(Int(progressInformation! * 100)) %"
        }
    }
    
    @IBOutlet weak var progressGoal: UILabel!  {
        didSet {
            progressGoal.text = "Всё получится!"
            progress.backgroundColor = .white
            progressGoal.textColor = .systemGray
            progressGoal.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        }
    }
    
    @IBOutlet weak var progress: UIProgressView!{
        didSet {
            progress.tintColor = UIColor(red: 161/255, green: 22/255, blue: 204/255, alpha: 0.5)
            print("Работает")
        }
    }
    
    @IBOutlet weak var countProgress: UILabel! {
        didSet {
            
            countProgress.backgroundColor = .white
            countProgress.textColor = .systemGray
            countProgress.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        }
    }
    
    static func nibInstance() -> CellProgress {
        let nib = Bundle.main.loadNibNamed(String(describing: CellProgress.self), owner: nil, options: nil)
        return nib!.first as! CellProgress
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layer.cornerRadius = 8
    }
}
