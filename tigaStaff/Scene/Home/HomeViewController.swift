//
//  HomeViewController.swift
//  tigaStaff
//
//  Created by Samet Korkmaz on 16.09.2024.
//

import UIKit
import SnapKit

protocol HomeViewInterface: AnyObject {
    func configureHomePage()
    func addSubViews()
    func addViewsLayuouts()
    func prepareScrolView()
}

final class HomeViewController: UIViewController {

    private let messageButton: UIButton = {
        let btn = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .black, scale: .large)
        let largeImage = UIImage(systemName: "paperplane.fill", withConfiguration: largeConfig)
        btn.setImage(largeImage, for: .normal)
        btn.tintColor = .tigaPick
        return btn
    }()
    private let scrolView: UIScrollView = {
        let scrolView = UIScrollView()
        scrolView.backgroundColor = .white
        return scrolView
    }()
    private let weatherView: WeatherView = {
        let view = WeatherView()
        return view
    }()
    private let announcementLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Adem Bey'den mesaj var!"
        lbl.textColor = .tigaDarkBlue
        lbl.font = .systemFont(ofSize: 18, weight: .bold)
        return lbl
    }()
    private let announcementView: UIView = {
        let view = AnnouncementView()
        view.backgroundColor = .newWhite
        return view
    }()
    private let storiesLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Başarı Hikayeleri"
        lbl.textColor = .tigaDarkBlue
        lbl.font = .systemFont(ofSize: 18, weight: .bold)
        return lbl
    }()
    private let storiesView: storiesCollectionView = {
        let view = storiesCollectionView()
        view.backgroundColor = .tigaLightWhite
        return view
    }()
    private let productsLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Ürünlerimiz"
        lbl.textColor = .tigaDarkBlue
        lbl.font = .systemFont(ofSize: 18, weight: .bold)
        return lbl
    }()
    private let productsView: produtcsCollectionView = {
        let view = produtcsCollectionView()
        view.backgroundColor = .tigaLightWhite
        return view
    }()
    private let tigaVakfiLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "tiga Vakfı Etkinliklerimiz"
        lbl.textColor = .tigaDarkBlue
        lbl.font = .systemFont(ofSize: 18, weight: .bold)
        return lbl
    }()
    private let tigaVakfiView: tigaVakfiCollectionView = {
        let view = tigaVakfiCollectionView()
        view.backgroundColor = .tigaLightWhite
        return view
    }()
    
    private lazy var viewModel = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true) // Geri dönerken tekrar göster
    }
    
    @objc func messageButtonTarget(){
        let messageVC = MessageViewController()
        messageVC.modalPresentationStyle = .fullScreen
        present(messageVC, animated: false, completion: nil)
    }
}
extension HomeViewController: HomeViewInterface{
    
    func configureHomePage() {
        view.backgroundColor = .tigaLightWhite
        storiesView.delegate = self
        productsView.delegate = self
        tigaVakfiView.delegate = self
        
        messageButton.addTarget(self, action: #selector(messageButtonTarget), for: .touchUpInside)

        [ announcementView, storiesView, productsView, tigaVakfiView].forEach{
            addShadowUIViews($0)
        }
    }
    func prepareScrolView() {
        scrolView.bounces = false // esnemez
        scrolView.alwaysBounceHorizontal = false // Yatay kaydırmayı devre dışı bırakır
        scrolView.alwaysBounceVertical = true   // Sadece dikey kaydırma açık kalır
        scrolView.showsHorizontalScrollIndicator = false // Yatay kaydırma göstergesini gizler
        scrolView.showsVerticalScrollIndicator = false
    }
    func addShadowUIViews(_ to: UIView){
        to.layer.shadowColor = UIColor.lightGray.cgColor // Gölge rengi (siyah)
        to.layer.shadowOpacity = 0.7 // Gölgenin opaklığı (0.0 - 1.0 arası)
        to.layer.shadowOffset = CGSize(width: 0, height: 2) // Gölge kaydırması (yatay ve dikey)
        to.layer.shadowRadius = 3 // Gölge bulanıklık yarıçapı
        to.layer.masksToBounds = false // Gölgenin görünmesi için masksToBounds false olmalı
    }

    func addSubViews() {
        [scrolView].forEach{
            self.view.addSubview($0)
        }
        [weatherView, announcementLabel, announcementView, storiesLabel, storiesView, productsLabel, productsView, tigaVakfiLabel, tigaVakfiView].forEach{
            self.scrolView.addSubview($0)
        }
    }
    
    func addViewsLayuouts() {

        scrolView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        weatherView.snp.makeConstraints { make in
            make.top.equalTo(scrolView.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.height.equalTo(view.snp.height).multipliedBy(0.3)
        }
        announcementLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(view.frame.width * 0.03)
            make.top.equalTo(weatherView.snp.bottom)
            make.bottom.equalTo(announcementView.snp.top)
        }
        announcementView.snp.makeConstraints { make in
            make.top.equalTo(weatherView.snp.bottom).offset(view.frame.height * 0.04)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.height.equalTo(view.snp.height).multipliedBy(0.2)
        }
        storiesLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(view.frame.width * 0.03)
            make.top.equalTo(announcementView.snp.bottom)
            make.bottom.equalTo(storiesView.snp.top)
        }
        storiesView.snp.makeConstraints { make in
            make.top.equalTo(announcementView.snp.bottom).offset(view.frame.height * 0.04)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.height.equalTo(view.snp.height).multipliedBy(0.24)

        }
        productsLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(view.frame.width * 0.03)
            make.top.equalTo(storiesView.snp.bottom)
            make.bottom.equalTo(productsView.snp.top)
        }
        productsView.snp.makeConstraints { make in
            make.top.equalTo(storiesView.snp.bottom).offset(view.frame.height * 0.04)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.height.equalTo(self.view.snp.height).multipliedBy(0.24)
        }
        tigaVakfiLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(view.frame.width * 0.03)
            make.top.equalTo(productsView.snp.bottom)
            make.bottom.equalTo(tigaVakfiView.snp.top)
        }
        tigaVakfiView.snp.makeConstraints { make in
            make.top.equalTo(productsView.snp.bottom).offset(view.frame.height * 0.04)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.height.equalTo(self.view.snp.height).multipliedBy(0.24)
            make.bottom.equalTo(scrolView.snp.bottom).offset(-20) // ScrollView'in içerik yüksekliğini belirleyen en son görünüm
        }
    }
    
}
extension HomeViewController: storiesCollectionViewsDelegate {
    
    func storiesCollectionViewItemTapped() {
        let selectedStory = storiesView.stories[storiesView.selectedIndex]

        let detailVC = DetailViewController()
        detailVC.viewModel.imageURL = selectedStory.imageURL
        detailVC.viewModel.titleText = selectedStory.title
        detailVC.viewModel.descriptionText = selectedStory.description
        
        detailVC.modalPresentationStyle = .fullScreen
        present(detailVC, animated: true, completion: nil)
    }
}
extension HomeViewController: produtcsCollectionViewsDelegate {
    func produtcsCollectionViewItemTapped() {
        let selectedStory = productsView.produtcs[productsView.selectedIndex]

        let detailVC = DetailViewController()
        detailVC.viewModel.imageURL = selectedStory.imageURL
        detailVC.viewModel.titleText = selectedStory.title
        detailVC.viewModel.descriptionText = selectedStory.description
        
        detailVC.modalPresentationStyle = .fullScreen
        present(detailVC, animated: true, completion: nil)
    }
}
extension HomeViewController: tigaVakfiCollectionViewsDelegate {
    func tigaVakfiCollectionViewItemTapped() {
        let selectedStory = tigaVakfiView.tigaActivities[tigaVakfiView.selectedIndex]

        let detailVC = DetailViewController()
        detailVC.viewModel.imageURL = selectedStory.imageURL
        detailVC.viewModel.titleText = selectedStory.title
        detailVC.viewModel.descriptionText = selectedStory.description
        
        detailVC.modalPresentationStyle = .fullScreen
        present(detailVC, animated: true, completion: nil)
    }
}

