//
//  YMTProductDetalisController.swift
//  Yamoto
//
//  Created by pactera on 2020/11/2.
//  Copyright © 2020 pactera. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources


class YMTProductDetalisController: YMTBaseViewController, UIScrollViewDelegate {

  private  lazy var collectionView = { () -> YMTProductDetailsCollectionView in
           let flowyout = UICollectionViewFlowLayout()
               flowyout.minimumLineSpacing = 1
               flowyout.minimumInteritemSpacing = 0
           let colleView = YMTProductDetailsCollectionView(frame:CGRect.zero,collectionViewLayout: flowyout)
           return colleView
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "详细"
        navigationItem.titleView?.tintColor = .black
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.right.bottom.left.equalToSuperview().offset(0)
            make.top.equalToSuperview().offset(kTopHeight)
        }
        
        let data1 = YMTProductDetailsViewModel.loadHomePageLocalDate()

                let dataSource = RxCollectionViewSectionedReloadDataSource<HomePage>(

                    configureCell:  { (dataSource, collectionView, indexPath, element) -> UICollectionViewCell in

                        switch indexPath.section {
                        case 0:
                            let cell : YMTDetalisCollectionTitleCell = collectionView.dequeueReusableCell(withReuseIdentifier: "YMTDetalisCollectionTitleCell", for: indexPath) as! YMTDetalisCollectionTitleCell
                            return cell
                        default :
                            let cell : YMTCollectionTitleCell = collectionView.dequeueReusableCell(withReuseIdentifier: "YMTCollectionTitleCell", for: indexPath) as! YMTCollectionTitleCell
                            //cell.contentLabel.text = element.title
                            //cell.titleLabel.text = element.content
                            return cell
                        }
                },
                configureSupplementaryView: {(dataSource ,collectionView, kind, indexPath) in
                    
                    var section : UICollectionReusableView?
                    switch indexPath.section {
                    case 1 :
                        section = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "YMTDetalisCollectionReusableView", for: indexPath) as! YMTDetalisCollectionReusableView
                                            
                        return section!
                    default :
                        return section!
                    }
                    
                }
        )
                
        data1.bind(to: collectionView.rx.items(dataSource: dataSource))
                    .disposed(by: disposeBag)
                collectionView.rx.setDelegate(self)
                    .disposed(by: disposeBag)
                
        
        collectionView.rx.itemSelected
            .subscribe(onNext:{ [weak self] indexPath in
                
                    let vc = YMTProductDetalisController()
                    self?.navigationController?.pushViewController(vc, animated: true)
                //防止详情无限点击，在push第6个控制器中删除当前navigationController栈中最早的详情控制器
                if  self?.navigationController?.viewControllers.count == 6{
                    self?.navigationController?.viewControllers .remove(at: 2)
                }
            })
        .disposed(by:disposeBag)
        
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension YMTProductDetalisController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.section {
        case 0:
            return CGSize(width: collectionView.frame.size.width, height: 500)

        default:
            return CGSize(width: (collectionView.frame.size.width - 5)/2, height: (collectionView.frame.size.width - 1)/2 + 90)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if section == 1{
            return CGSize(width: collectionView.frame.size.width, height: 40)
        }
        return CGSize(width: 0, height: 0)
    }
    
}
