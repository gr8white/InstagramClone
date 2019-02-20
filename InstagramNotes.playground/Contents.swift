import Parse

//Saving to the database ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
let comment = PFObject(className: "Comment")
 
comment["text"] = "Nice shot!"
 
comment.saveInBackground { (success, error) in
    if (success) {
     
        print("save successful")
     
    } else {
     
        print("save failed")
     
    }
}

//Retrieving from the database ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
let query = PFQuery(className: "Comment")
 
query.getObjectInBackground(withId: "43ZxzFi9ya") { (object, error) in //ID was copy and pasted from online database
    if let comment = object {
 
        if let text = comment["text"] {
 
            print(text)
 
        }
 
    }
}

//Updating the database ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
let query = PFQuery(className: "Comment")
 
query.getObjectInBackground(withId: "43ZxzFi9ya") { (object, error) in
    if let comment = object {
 
        comment["text"] = "Awful Shot!"
 
        comment.saveInBackground { (success, error) in
            if (success) {
 
                print("update successful")
 
            } else {
 
                print("update failed")
 
            }
 
        }
 
    }
}
