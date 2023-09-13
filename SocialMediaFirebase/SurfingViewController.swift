import UIKit
import Firebase

class SurfingViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getDataFromFirestore()
    }
    
    func getDataFromFirestore() {
        let fireStoreDatabase = Firestore.firestore()
        fireStoreDatabase.collection("Posts").addSnapshotListener { snapshot, error in
            if error != nil {
                print(error?.localizedDescription)
            }else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    for document in  snapshot!.documents{
                        let documentID = document.documentID
                        if let postedBy = document.get("PostedBy") as? String{
                            print(documentID)

                        }
                        
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell" , for: indexPath) as! TableViewCell
        cell.userNameText.text = "User"
        cell.comentLabel.text = "Test"
        cell.likeLabel.text = "0"
        cell.disLikeLabel.text = "0"
        cell.userImageView.image = UIImage(named: "person.png")
        cell.userUploadImageView.image = UIImage(named: "person.png")
        return cell
    }
  

}
