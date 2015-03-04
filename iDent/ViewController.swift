//
//  ViewController.swift
//  iDent
//
//  Created by Vinicius Brito on 02/03/15.
//  Copyright (c) 2015 Vinicius. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate
{
    //Colocar no Define do app
    let link = "http://gdata.youtube.com/feeds/api/users/iDentBrasil/uploads"
    let sulfixoJson = "?&alt=json"
    let sulfixoMaxResults = "&&max-results=30"
    
    var refreshControl:UIRefreshControl!
    
    var intIndex = 0
    var arrayTableView = [AnyObject]()
    
    @IBOutlet weak var tableViewVideos: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.refresh(self)

        self.refreshControl = UIRefreshControl()
        //self.refreshControl.attributedTitle = NSAttributedString(string: "Desça para recarregar")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableViewVideos.addSubview(refreshControl)
        
        self.title = "iDent"
    }
    
    func refresh(sender:AnyObject)
    {
        self.title = "Carregando..."

        var urlTotal = link + sulfixoJson + sulfixoMaxResults
        Service(url: urlTotal)
            {
                array in
                if(array? != nil)
                {
                    //Tira os dados das tags e cria um array de objetos para facilitar a manipulação dos dados
                    //println("array retorno\(array)")
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
                self.tableViewVideos.reloadData()
                self.refreshControl.endRefreshing()
                self.title = "iDent"
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrayTableView.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell:VideosCell = self.tableViewVideos.dequeueReusableCellWithIdentifier("customCell") as VideosCell
        
        if let video = arrayTableView[indexPath.row] as? Video
        {
            cell.labelTitulo.text = video.titulo
            cell.loadImage(urlImage: video.thumb)
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        intIndex = indexPath.row
        self.performSegueWithIdentifier("segueInfo", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "segueInfo"
        {
            var detailVC = segue.destinationViewController as InfoViewController
            if let video = arrayTableView[intIndex] as? Video
            {
                detailVC.videoInfo = video
            }
        }
    }
}

