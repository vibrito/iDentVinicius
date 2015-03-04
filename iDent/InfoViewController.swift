//
//  InfoViewController.swift
//  iDent
//
//  Created by Vinicius Brito on 03/03/15.
//  Copyright (c) 2015 Vinicius. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController
{    
    var videoInfo = Video()
    
    @IBOutlet weak var imageViewThumb: UIImageView!
    @IBOutlet weak var labelTitulo: UILabel!
    @IBOutlet weak var labelDescricao: UILabel!
    @IBOutlet weak var labelDuracao: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        Utils.AsyncImage(url: videoInfo.thumb)
        {
            data in
            if(data? != nil)
            {
                self.imageViewThumb.image = UIImage (data: data!)
            }
        }
        
        Utils.ConverteSegundo(segundos: videoInfo.duracao)
        {
            duracao in
            if(duracao? != nil)
            {
                self.labelDuracao.text = String(duracao!)
            }
        }
        
        //println("Descrição: \(videoInfo.descricao)")
        labelDescricao.text = videoInfo.descricao
        labelTitulo.text = videoInfo.titulo
        
        self.title = "Detalhes"
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        var relacVC = segue.destinationViewController as RelacionadoViewController
        relacVC.videoRelacionados = videoInfo.relacionados
    }
    
    @IBAction func actionRelacionados(sender: AnyObject)
    {
        self.performSegueWithIdentifier("segueRelacionados", sender: self)
    }
    
    @IBAction func actionPlayVideo()
    {
        var video = XCDYouTubeVideoPlayerViewController (videoIdentifier: videoInfo.videoId)
        self.presentMoviePlayerViewControllerAnimated(video)
    }
}