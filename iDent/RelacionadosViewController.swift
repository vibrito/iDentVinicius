//
//  RelacionadosViewController.swift
//  iDent
//
//  Created by Vinicius Brito on 04/03/15.
//  Copyright (c) 2015 Vinicius. All rights reserved.
//

import UIKit

class RelacionadoViewController: UIViewController, UITableViewDelegate
{
    //Colocar no Define do app
    let sulfixoJson = "?&alt=json"
    let sulfixoMaxResults = "&&max-results=1"
    
    var videoRelacionados = String()
    var arrayTableView = [AnyObject]()
    
    var refreshControl:UIRefreshControl!
    
    @IBOutlet weak var tableViewRelacionados: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.refresh(self)
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableViewRelacionados.addSubview(refreshControl)
        
        self.title = "Relacionados"
    }
    
    func refresh(sender:AnyObject)
    {
        var urlTotal = videoRelacionados + sulfixoJson
        Service(url: urlTotal)
        {
            array in
            if(array? != nil)
            {
                //Tira os dados das tags e cria um array de objetos para facilitar a manipulação dos dados
                self.criaObjetos(array!)
            }
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func criaObjetos(array: NSArray)
    {
        Utils.CriaObjetos(array: array)
        {
            arrayReturn in
            if(arrayReturn? != nil)
            {
                self.arrayTableView = arrayReturn!
                self.tableViewRelacionados.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrayTableView.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell:VideosCell = self.tableViewRelacionados.dequeueReusableCellWithIdentifier("customCell") as VideosCell
        
        if let video = arrayTableView[indexPath.row] as? Video
        {
            cell.labelTitulo.text = video.titulo
            cell.loadImage(urlImage: video.thumb)
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if let video = arrayTableView[indexPath.row] as? Video
        {
            var video = XCDYouTubeVideoPlayerViewController (videoIdentifier: video.videoId)
            self.presentMoviePlayerViewControllerAnimated(video)
        }
    }
}
