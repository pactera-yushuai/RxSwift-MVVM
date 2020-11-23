//
//  YMTHomePageController.swift
//  Yamoto
//
//  Created by 王健 on 2020/10/25.
//  Copyright © 2020 pactera. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources
import ESPullToRefresh
import Kingfisher

class YMTHomePageController: YMTBaseViewController {
    
   private lazy var collectionView = { () -> YMTCollectionView in
        let flowyout = UICollectionViewFlowLayout()
            flowyout.minimumLineSpacing = 1
            flowyout.minimumInteritemSpacing = 0
        let colleView = YMTCollectionView(frame:CGRect.zero,collectionViewLayout: flowyout)
        return colleView
    }()
    
   private lazy   var searchBar   = {() -> UISearchBar  in
        let bar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            bar.placeholder = NSLocalizedString("SearchPlaceholder", comment: "")
            bar.searchTextField.backgroundColor = SerachColor
        return bar
    }()
    
   private lazy var leftNavBarButton : YMTNavBarButton = YMTNavBarButton(frame: CGRect(x: 0, y: 0, width: 45, height: 35))
   private lazy var rightNavBarButton : YMTNavBarButton = YMTNavBarButton(frame: CGRect(x: 0, y: 0, width: 45, height: 35))
    
    override func viewDidLoad() {
        super.viewDidLoad()
         setupUI()
         bindView()
      }
}


extension YMTHomePageController {
    
    fileprivate func setupUI() {
        leftNavBarButton.BarButton.setTitle("东京", for: .normal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView:leftNavBarButton)
        rightNavBarButton.BarButton.setBackgroundImage(UIImage(named: "taobao"), for: .normal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView:rightNavBarButton)
        navigationItem.titleView = searchBar
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.right.bottom.left.equalToSuperview().offset(0)
        }
    }
    
    fileprivate func bindView() {
        
       // let data1 = YMTHomePageViewModel.loadHomePageLocalDate()
               
               let dataSource = RxCollectionViewSectionedReloadDataSource<HomePage>(
                   configureCell:  { (dataSource, collectionView, indexPath, element) -> UICollectionViewCell in
                       switch indexPath.section {
                       case 0:
                           let cell : YMTautoScrollViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "YMTautoScrollViewCell", for: indexPath) as! YMTautoScrollViewCell
                           
                                cell.autoScrollView.images = element.imageUrl
                                 return cell
                       case 1 :
                           let cell : YMTCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "YMTCollectionCell", for: indexPath) as! YMTCollectionCell
                                cell.iconImage.image = UIImage(named: element.imageName!)
                                cell.contentLabel.text = element.title
                                            return cell
                       default :
                           let cell : YMTCollectionTitleCell = collectionView.dequeueReusableCell(withReuseIdentifier: "YMTCollectionTitleCell", for: indexPath) as! YMTCollectionTitleCell
              
                           cell.titleLabel.text = element.good_name
                           cell.activitiesLabel.text = element.good_info
                           cell.priceLabel.text = "$" + element.good_price!
                           
                           if let url = URL(string: element.good_url!) {
                               cell.iconImage.kf.setImage(with: url)
                           }
                           return cell
                       }
               })
               
        
        let input =   YMTHomePageViewModel.Input(category: .homePagelist("date", 10, 10),loadDateStatus: .none)
        
        let datas  = YMTHomePageViewModel.loadHomePageListLocalDate(input: input)
        
        collectionView.es.addPullToRefresh {
                   [unowned self] in
                   /// 在这里做刷新相关事件
                   /// 如果你的刷新事件成功，设置completion自动重置footer的状态
                   //监听第一个输入源 刷新
            
            //input.loadDateStatus.
                 print("刷新数据")
                   self.collectionView.es.stopPullToRefresh()
                   /// 设置ignoreFooter来处理不需要显示footer的情况
                   self.collectionView.es.stopPullToRefresh()
               }
               
               collectionView.es.addInfiniteScrolling {
                   [unowned self] in
                        //监听第二个输入源 加载
                   /// 在这里做加载更多相关事件
                ///
                      print("加载更多")
                   /// ...
                   /// 如果你的加载更多事件成功，调用es_stopLoadingMore()重置footer状态
                   self.collectionView.es.stopLoadingMore()
                   /// 通过es_noticeNoMoreData()设置footer暂无数据状态
                 //  self.collectionView.es.noticeNoMoreData()
               }
        
//        
//        datas.dataSource.bind(to: collectionView.rx.items(dataSource: dataSource))
//                    .disposed(by: disposeBag)
//                collectionView.rx.setDelegate(self)
//                    .disposed(by: disposeBag)
//
//                collectionView.rx.itemSelected
//                    .subscribe(onNext:{ [weak self] indexPath in
//                     
//                        if indexPath.row == 0 && indexPath.section == 2 {
//                            let vc = YMTTaobaoList()
//                            self?.navigationController?.pushViewController(vc, animated: true)
//                        }
//                        else if indexPath.row == 2 && indexPath.section == 2 {
//                            let vc = YMTProductDetalisController()
//                            self?.navigationController?.pushViewController(vc, animated: true)
//                        }
//                        else{
//                            let vc = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "YMTLoginViewController")
//                                self!.present(vc, animated: true, completion: nil)
//                        }
//                    })
//                .disposed(by:disposeBag)
//  
    }
}




extension YMTHomePageController : UICollectionViewDelegate{
    
}

extension YMTHomePageController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: collectionView.frame.size.width, height: 180)
        case 1:
            return CGSize(width: (collectionView.frame.size.width - 1)/5, height: (collectionView.frame.size.width - 1)/5)
        default:
            return CGSize(width: (collectionView.frame.size.width - 5)/2, height: (collectionView.frame.size.width - 1)/2 + 90)
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: collectionView.frame.size.width, height: 40)
//    }
    
}


