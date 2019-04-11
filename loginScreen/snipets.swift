0. add delegate methods to class inheritance
UIImagePickerControllerDelegate,
UINavigationControllerDelegate

1. instantiate ImagePicker in VC class
let vc = UIImagePickerController()

2. in viewDidLoad, set the delegate:
vc.delegate = self
vc.sourceType = .camera

3. implement ImagePicker methods:
func imagePickerController(_ picker: UIImagePickerController,
    didFinishPickingMediaWithInfo info: [String : AnyObject])
{
    let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
    myImageView.contentMode = .scaleAspectFit //3
    myImageView.image = chosenImage //4
    dismiss(animated:true, completion: nil) //5      
}

func imagePickerControllerDidCancel(_ picker: UIImagePickerController) 
{
         
}

func imagePickerControllerDidCancel(_ picker: UIImagePickerController) 
{
       dismiss(animated: true, completion: nil)
}

4. edit info.plist:
-Right click on the Information Property List Row. In the menu that appears, select Add Row.
-You get a new row with a drop down menu. Select Privacy – Photo Library Usage… from the menu.
-With the row still highlighted, click the value column  and add why you want access to the photo library.
In this app we are setting a background image.
