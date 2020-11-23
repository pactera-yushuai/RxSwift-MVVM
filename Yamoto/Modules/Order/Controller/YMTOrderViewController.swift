//
//  YMTOrderViewController.swift
//  Yamoto
//
//  Created by pactera on 2020/10/23.
//  Copyright © 2020 pactera. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources


class YMTOrderViewController: YMTBaseViewController {

     var disposeBag11 = DisposeBag()
        
     private  lazy var collectionView = { () -> YMTHeardCollectionView in
              let flowyout = UICollectionViewFlowLayout()
                  flowyout.minimumLineSpacing = 1
                  flowyout.minimumInteritemSpacing = 0
              let colleView = YMTHeardCollectionView(frame:CGRect.zero,collectionViewLayout: flowyout)
              return colleView
          }()
      private  var tableView:YMTBaseTableView!
        
        
      let heardDataSource = RxCollectionViewSectionedReloadDataSource<YMTTaoBaoModel>(
                    configureCell:  { (dataSource, collectionView, indexPath, element) -> UICollectionViewCell in
                     
                    let cell : YMTTaobaoTitleCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "YMTTaobaoTitleCollectionCell", for: indexPath) as! YMTTaobaoTitleCollectionCell
                            cell.contentLabel.text = element.title
                        return cell
                    },
                     configureSupplementaryView: {(dataSource ,collectionView, kind, indexPath) in
                                
                    let  section = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "YMTDetalisCollectionReusableView", for: indexPath) as! YMTDetalisCollectionReusableView
                        section.titleContent.text =    "最近访问店铺"
                        section.titleContent.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                        section.titleContent.textAlignment = .left
                        return section
                }
        )

        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            navigationItem.title = "淘宝"
            
            tableView = YMTBaseTableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0),style: .plain)
            
            collectionView.frame = CGRect(x: 0, y: 0, width: Int(view.frame.size.width), height: 150)
            tableView.tableHeaderView = collectionView
            tableView.separatorStyle = .none;
            tableView.register(YMTTaobaoCell.self, forCellReuseIdentifier: "YMTTaobaoCell")
            view.addSubview(self.tableView)
            
            tableView.snp.makeConstraints { (make) in
                make.right.top.bottom.left.equalToSuperview().offset(0)
            }
            
                let dataSource =
                    RxTableViewSectionedReloadDataSource<YMTTaoBaoModel>(
                            
                    configureCell: { (_, tv, indexPath, element) in
                     let cell =  YMTTaobaoCell().baseTableViewCell(tb: tv, RID: "YMTTaobaoCell")
                        
                        print(element)
                       // cell.imageUrls = element
            //                let items = Observable.just([
            //                        SectionModel(model: "", items: element.imageUrl!)
            //                       ])
            //                       //绑定单元格数据
            //                items.bind(to: cell.collectionView.rx.items(dataSource: cell.dataSource))
            //                .disposed(by: cell.disposeBag)
                        return cell
                       }
                )
            
            
            let ViewModel = TabBaoViewModel(dependency: .getShopList("", 10, 10))
            
           
            ViewModel.getListDate(index: 10, pages: 10)
            
            
   
   //         let input =   YMTTaoBaoViewModel.Input(category: .homePagelist("date", 10, 10))
//
      //      let dates = YMTTaoBaoViewModel().loadListLocalDate(input:input)
            
            //let date1 =  YMTTaoBaoViewModel.loadLocalDate()
            
            ViewModel.datasource
                .bind(to: tableView.rx.items(dataSource: dataSource))
               .disposed(by: disposeBag)

            tableView.rx
                .itemSelected
                .map { indexPath in
                    return (indexPath, dataSource[indexPath])
                }
                .subscribe(onNext: { pair in
                    print(pair.0)
                    DefaultWireframe.presentAlert("Tapped `\(pair.1)` @ \(pair.0)")
                })
                .disposed(by: disposeBag)
            
            tableView.rx
                .setDelegate(self)
                .disposed(by: disposeBag)
            
            //let date2 = YMTTaoBaoViewModel.loadHeardDate()
            
            ViewModel.datasource.bind(to: collectionView.rx.items(dataSource: heardDataSource))
                     .disposed(by: disposeBag11)
                 collectionView.rx.setDelegate(self)
                     .disposed(by: disposeBag11)
            
            collectionView.rx.itemSelected
                    .subscribe(onNext:{ [weak self] indexPath in
                        
                        let vc = YMTProductDetalisController()
                        self?.navigationController?.pushViewController(vc, animated: true)
                    })
                .disposed(by:disposeBag11)
            // Do any additional setup after loading the view.
            
            
           
            
            
            ViewModel.refreshStatus.asObservable().subscribe(onNext: {[weak self] status in
                       
                switch status {
                case .endHeaderRefresh:
                    self?.tableView.es.stopPullToRefresh()
                    break
                case .endFooterRefresh:
                    self?.tableView.es.stopLoadingMore()
                    break
                case .none: break
                case .beingHeaderRefresh: break
                case .beingFooterRefresh: break
                case .noMoreData: break
                }
                   
            }).disposed(by: disposeBag11)
            
            
            tableView.es.addPullToRefresh {
                            [unowned self] in
                            /// 在这里做刷新相关事件
                            /// 如果你的刷新事件成功，设置completion自动重置footer的状态
                            //监听第一个输入源 刷新
                     
               ViewModel.requestCommond.onNext(true)
                     //input.loadDateStatus.
                          print("刷新数据")

//                ViewModel.requestCommond.drive(onNext: { (<#Bool#>) in
//                    <#code#>
//                }, onCompleted: {
//                    <#code#>
//                }) {
//
//                }
//
//                viewModel.requestCommond
//                       .drive(true)
//                       .disposed(by: disposeBag)
                
                self.tableView.es.stopPullToRefresh()

                
                }
                tableView.es.addInfiniteScrolling {
                            [unowned self] in
                                 //监听第二个输入源 加载
                            /// 在这里做加载更多相关事件
                               print("加载更多")
                            /// 如果你的加载更多事件成功，调用es_stopLoadingMore()重置footer状态
                          //   ViewModel.requestCommond.onNext(false)
                    
                            ViewModel.requestCommond.onNext(false)

                            self.tableView.es.stopLoadingMore()
                            /// 通过es_noticeNoMoreData()设置footer暂无数据状态
                         //   self.tableView.es.noticeNoMoreData()
                    }
            
        }
    }


    extension YMTOrderViewController: UITableViewDelegate {
        
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return  0.1
             }
        func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            return  0.1
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 510
        }
    }

    extension YMTOrderViewController : UICollectionViewDelegateFlowLayout{
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                return CGSize(width: (collectionView.frame.size.width - 1)/4, height: (collectionView.frame.size.width - 1)/4)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize(width: collectionView.frame.size.width, height: 40)
        }
    }
