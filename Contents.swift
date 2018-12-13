import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
        
        let screenSize = UIScreen.main.bounds
        
        print(screenSize)
        
        let mainView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        mainView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        
        
        self.view = mainView
        
        let fontSize: CGFloat = 48.0
        
        let fontURL = Bundle.main.url(forResource: "PTN57F", withExtension: "ttf")
        CTFontManagerRegisterFontsForURL(fontURL! as CFURL, CTFontManagerScope.process, nil)
        let fontURL2 = Bundle.main.url(forResource: "PTN77F", withExtension: "ttf")
        CTFontManagerRegisterFontsForURL(fontURL2! as CFURL, CTFontManagerScope.process, nil)

        //let distanceText = "2.8 mi"
        let dtl = CATextLayer()
        
        let regFont = UIFont(name: "PTSans-Narrow", size: fontSize * 0.75 )
        let boldFont = UIFont(name: "PTSans-NarrowBold", size: fontSize)
        let boldText = "12.5"
        let regText = " mi"
        let textColor = UIColor(red: 0.0, green: 27/255, blue: 192/255, alpha: 1.0)
        let attrs = [NSAttributedString.Key.font : boldFont, NSAttributedString.Key.foregroundColor: textColor]
        
        let attrStr = NSMutableAttributedString(string: boldText, attributes: attrs as [NSAttributedString.Key : Any])
        
        let regAttrs = [NSAttributedString.Key.font : regFont, NSAttributedString.Key.foregroundColor: textColor]
        let regAttrStr = NSMutableAttributedString(string: regText, attributes: regAttrs as [NSAttributedString.Key : Any])
        
        attrStr.append(regAttrStr)
        
        //dtl.string = distanceText
        dtl.string = attrStr
       // dtl.font = CGFont("PTSans-Narrow" as CFString)
       // dtl.fontSize = 12
        dtl.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 0.0).cgColor
       // dtl.foregroundColor = UIColor(red: 0.0, green: 27/255, blue: 192/255, alpha: 1.0).cgColor
        dtl.alignmentMode = .center
        dtl.contentsCenter
        dtl.contentsScale = UIScreen.main.scale
        
        print("preferredFrameSize: \(dtl.preferredFrameSize())")
        
        
        let dtlWidth: CGFloat = dtl.preferredFrameSize().width
        let dtlHeight: CGFloat = dtl.preferredFrameSize().height
        let padding: CGFloat = fontSize * 0.5
        let capsuleWidth = dtlWidth + padding
        let capsuleHeight = dtlHeight * 0.875// + (padding / 4)
        
         dtl.frame = CGRect(x: padding  / 2 , y: (capsuleHeight - dtlHeight) / 2 , width: dtlWidth, height: dtlHeight)
        
        let capsule = CALayer()
        capsule.frame = CGRect(x: 0, y: 0, width: capsuleWidth, height: capsuleHeight)
        
        capsule.cornerRadius = capsuleHeight / 2
        capsule.backgroundColor = UIColor.yellow.cgColor
        
        let capsuleView = UIView()
        let capsuleViewX = (mainView.bounds.width / 2)  - (capsuleWidth / 2)
        let capsuleViewY = (mainView.bounds.height / 2) - (capsuleHeight / 2)
        print(capsuleViewX, capsuleViewY)
        
        capsuleView.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 1.0, alpha: 0.0)
        
        capsuleView.frame = CGRect(x: capsuleViewX, y: capsuleViewY, width: capsuleWidth, height: capsuleHeight)
        
        print("capsuleView.frame: \(capsuleView.frame)")
        
        capsuleView.layer.addSublayer(capsule)
        capsuleView.layer.addSublayer(dtl)
        
        mainView.addSubview(capsuleView)
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController().view
