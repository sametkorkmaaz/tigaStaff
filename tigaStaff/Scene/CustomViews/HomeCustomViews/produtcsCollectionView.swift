//
//  produtcsCollectionView.swift
//  tigaStaff
//
//  Created by Samet Korkmaz on 17.09.2024.
//

import UIKit
import SnapKit
import Kingfisher

protocol produtcsCollectionViewsDelegate: AnyObject {
    func produtcsCollectionViewItemTapped()
}

class produtcsCollectionView: UIView {
    weak var delegate: produtcsCollectionViewsDelegate?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        collectionView.backgroundColor = .white.withAlphaComponent(0.9)
        return collectionView
    }()

    var produtcs: [NewsModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    var selectedIndex: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        fetchDataFromFirestore(collectionName: "produtcs")
        collectionView.dataSource = self
        collectionView.delegate = self
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCollectionView()
    }
    func fetchDataFromFirestore(collectionName: String) {
        FirebaseFireStore.shared.fetchTigaNews(from: collectionName) { news, error in
            if let error = error {
                print("Error fetching users from \(collectionName): \(error)")
                return
            }
            if let news = news {
                self.produtcs.append(contentsOf: news)
            }
        }
    }
    func setupCollectionView(){
        collectionView.layer.shadowColor = UIColor.lightGray.cgColor // Gölge rengi (siyah)
        collectionView.layer.shadowOpacity = 0.9 // Gölgenin opaklığı (0.0 - 1.0 arası)
        collectionView.layer.shadowOffset = CGSize(width: 0, height: 2) // Gölge kaydırması (yatay ve dikey)
        collectionView.layer.shadowRadius = 9 // Gölge bulanıklık yarıçapı
        collectionView.layer.masksToBounds = false // Gölgenin görünmesi için masksToBounds false olmalı
        addSubview(collectionView)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
extension produtcsCollectionView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return produtcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = .newWhite
        cell.imageViewCell.kf.setImage(with: URL(string: produtcs[indexPath.row].imageURL))
        cell.titleLabel.text = produtcs[indexPath.row].title
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        delegate?.produtcsCollectionViewItemTapped()
    }
}
extension produtcsCollectionView: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewHeight = collectionView.frame.height
        return CGSize(width: collectionViewHeight * 8/7, height: collectionViewHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 500
    }
}

#Preview(){
    HomeViewController()
}
