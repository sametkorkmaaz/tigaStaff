//
//  FirebaseFireStore.swift
//  tigaStaff
//
//  Created by Samet Korkmaz on 17.09.2024.
//

import Foundation
import FirebaseFirestore

// Firestore erişimi için singleton sınıfı
protocol FirebaseFireStoreInterface {
    
    func fetchTigaNews(from collectionName: String, completion: @escaping ([NewsModel]?, Error?) -> Void)
    func saveUserFirestore(collectionName: String, userName: String, userLastName: String, dateOfBirth: String, userGender: String, userRole: String, userEmail: String, completion: @escaping (Error?) -> Void) async
    func fetchTigaUsers(completion: @escaping ([UserModel]?, Error?) -> Void)
    func fetchTigaUserWithUserEmail(email: String, completion: @escaping (UserModel?, Error?) -> Void)
}

class FirebaseFireStore: FirebaseFireStoreInterface {
    
    static let shared = FirebaseFireStore() // Singleton
    
    private init() {} // Dışarıdan instance oluşturulamaz

    private let db = Firestore.firestore()

    // Parametre olarak collectionName alan genel fonksiyon
    func fetchTigaNews(from collectionName: String, completion: @escaping ([NewsModel]?, Error?) -> Void) {
        db.collection(collectionName).getDocuments { (snapshot, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            var newsArray: [NewsModel] = []
            
            // Dönen verileri User modeline çeviriyoruz
            for document in snapshot!.documents {
                let data = document.data()
                _ = document.documentID
                let imageURL = data["imageURL"] as? String ?? "No image"
                let title = data["title"] as? String ?? "No email"
                let description = data["description"] as? String ?? "No description"
                
                let news = NewsModel(imageURL: imageURL, title: title, description: description)
                newsArray.append(news)
            }
            
            // Başarıyla verileri döndürüyoruz
            completion(newsArray, nil)
        }
    }
    
    func saveUserFirestore(collectionName: String, userName: String, userLastName: String, dateOfBirth: String, userGender: String, userRole: String, userEmail: String, completion: @escaping (Error?) -> Void) async {
        do {
          let ref = try await db.collection(collectionName).addDocument(data: [
            "name": userName,
            "lastName": userLastName,
            "dateOfBirth": dateOfBirth,
            "gender": userGender,
            "role": userRole,
            "email": userEmail
          ])
          print("Document added with ID: \(ref.documentID)")
        } catch {
          print("Error adding document: \(error)")
        }
    }
    func fetchTigaUsers(completion: @escaping ([UserModel]?, Error?) -> Void) {
        db.collection("users").getDocuments { (snapshot, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            var usersArray: [UserModel] = []
            
            // Dönen verileri User modeline çeviriyoruz
            for document in snapshot!.documents {
                let data = document.data()
                let id = document.documentID
                let userName = data["name"] as? String ?? "No userName"
                let userLastName = data["lastName"] as? String ?? "No userLastName"
                let userDateOfBirth = data["dateOfBirth"] as? String ?? "No userDateOfBirth"
                let userRole = data["role"] as? String ?? "No userRole"
                let userGender = data["gender"] as? String ?? "No userGender"
                let userEmail = data["email"] as? String ?? "No userEmail"
                
                let users = UserModel(id: id, email: userEmail, name: userName, lastName: userLastName, dateOfBirth: userDateOfBirth, role: userRole, gender: userGender)
                usersArray.append(users)
            }
            
            // Başarıyla verileri döndürüyoruz
            completion(usersArray, nil)
        }
    }
    
    func fetchTigaUserWithUserEmail(email: String, completion: @escaping (UserModel?, Error?) -> Void) {
        db.collection("users").whereField("email", isEqualTo: email).getDocuments { (snapshot, error) in
            if let error = error {
                completion(nil, error)
                return
            }

            // Eğer dönen snapshot'ta bir kullanıcı varsa
            if let document = snapshot?.documents.first {
                let data = document.data()
                let id = document.documentID
                let userName = data["name"] as? String ?? "No userName"
                let userLastName = data["lastName"] as? String ?? "No userLastName"
                let userDateOfBirth = data["dateOfBirth"] as? String ?? "No userDateOfBirth"
                let userRole = data["role"] as? String ?? "No userRole"
                let userGender = data["gender"] as? String ?? "No userGender"
                let userEmail = data["email"] as? String ?? "No userEmail"
                
                // UserModel nesnesini oluşturuyoruz
                let user = UserModel(id: id, email: userEmail, name: userName, lastName: userLastName, dateOfBirth: userDateOfBirth, role: userRole, gender: userGender)
                
                // Kullanıcıyı döndürüyoruz
                completion(user, nil)
            } else {
                // Eğer e-posta adresine sahip kullanıcı yoksa
                completion(nil, nil)
            }
        }
    }
    
}
