import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
        
        let screenSize = UIScreen.main.bounds
        
        print(screenSize)
        
        let mainView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        mainView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        
        self.view = mainView
        
        let fontURL = Bundle.main.url(forResource: "PTN57F", withExtension: "ttf")
        CTFontManagerRegisterFontsForURL(fontURL! as CFURL, CTFontManagerScope.process, nil)
        let fontURL2 = Bundle.main.url(forResource: "PTN77F", withExtension: "ttf")
        CTFontManagerRegisterFontsForURL(fontURL2! as CFURL, CTFontManagerScope.process, nil)
        
        let textColor = UIColor(red: 0.0, green: 27/255, blue: 192/255, alpha: 1.0)
        let backgroundColor = UIColor.yellow
        
        let myCapsuleView = createLabel(fontSize: 48, valueText: "2.8", unitsText: .mi, textColor: textColor, backgroundColor: backgroundColor)
        
        let capsuleViewX = (mainView.bounds.width / 2)  - (myCapsuleView.bounds.width / 2)
        let capsuleViewY = (mainView.bounds.height / 2) - (myCapsuleView.bounds.height / 2)

        myCapsuleView.frame = CGRect(x: capsuleViewX, y: capsuleViewY, width: myCapsuleView.bounds.width , height: myCapsuleView.bounds.height)
        print("myCapsuleView.frame: \(myCapsuleView.frame)")
        
        mainView.addSubview(myCapsuleView)
    }
    
    
    enum Units: String {
        case mi = "mi"
    }
    
    func createLabel(fontSize: CGFloat, valueText: String, unitsText: Units, textColor: UIColor, backgroundColor: UIColor) -> UIView {

        let textLayer = CATextLayer()
        
        let unitsFont = UIFont(name: "PTSans-Narrow", size: fontSize * 0.75 )
        let valueFont = UIFont(name: "PTSans-NarrowBold", size: fontSize)
        
        let valueAttrs = [NSAttributedString.Key.font : valueFont, NSAttributedString.Key.foregroundColor: textColor]
        
        let formattedValueStr = NSMutableAttributedString(string: valueText, attributes: valueAttrs as [NSAttributedString.Key : Any])
        
        let unitsAttrs = [NSAttributedString.Key.font : unitsFont, NSAttributedString.Key.foregroundColor: textColor]
        let formattedUnitsStr = NSMutableAttributedString(string: " " + unitsText.rawValue, attributes: unitsAttrs as [NSAttributedString.Key : Any])
        
        formattedValueStr.append(formattedUnitsStr)
        
        textLayer.string = formattedValueStr
        textLayer.contentsScale = UIScreen.main.scale
        
        print("preferredFrameSize: \(textLayer.preferredFrameSize())")
        
        let textLayerWidth: CGFloat = textLayer.preferredFrameSize().width
        let textLayerHeight: CGFloat = textLayer.preferredFrameSize().height
        let padding: CGFloat = fontSize * 0.5
        let capsuleWidth = textLayerWidth + padding
        let capsuleHeight = textLayerHeight * 0.875
        
        textLayer.frame = CGRect(x: padding  / 2 , y: (capsuleHeight - textLayerHeight) / 2 , width: textLayerWidth, height: textLayerHeight)
        
        let capsule = CALayer()
        capsule.frame = CGRect(x: 0, y: 0, width: capsuleWidth, height: capsuleHeight)
        
        capsule.cornerRadius = capsuleHeight / 2
        capsule.backgroundColor = backgroundColor.cgColor
        
        let capsuleView = UIView()
        capsuleView.layer.addSublayer(capsule)
        capsuleView.layer.addSublayer(textLayer)
        capsuleView.frame = CGRect(x: 0, y: 0, width: capsuleWidth, height: capsuleHeight)

        return capsuleView
    }
    
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController().view
