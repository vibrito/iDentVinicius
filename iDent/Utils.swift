//
//  Utils.swift
//  iDent
//
//  Created by Vinicius Brito on 03/03/15.
//  Copyright (c) 2015 Vinicius. All rights reserved.
//

// http://stackoverflow.com/questions/26396301/setting-images-in-uitableviewcell-in-swift



class Utils
{
    //Recupera as imagens das thumbs assincronamente
    class AsyncImage
    {
        var url: String
        var callback: (NSData?) -> ()
        
        init(url: String, callback: (NSData?) -> ())
        {
            self.url = url
            self.callback = callback
            self.fetch()
        }
        
        func fetch()
        {
            var imageRequest: NSURLRequest = NSURLRequest(URL: NSURL(string: self.url)!)
            NSURLConnection.sendAsynchronousRequest(imageRequest,
                queue: NSOperationQueue.mainQueue(),
                completionHandler: { response, data, error in
                    if(error == nil)
                    {
                        self.callback(data)
                    }
                        
                    else
                    {
                        self.callback(nil)
                    }
            })
            
            callback(nil)
        }
    }
    
    class ConverteSegundo
    {
        var segundos: Int
        var callback: (NSString?) -> ()
        init(segundos: Int, callback: (NSString?) -> ())
        {
            self.segundos = segundos
            self.callback = callback
            self.converte()
        }
        
        func converte()
        {
            var segundosExtenso = (segundos % 60)
            var minutosExtenso = (segundos / 60)
            if (minutosExtenso > 0)
            {
                //Melhorar isso
                if  (segundosExtenso == 0)
                {
                    if (minutosExtenso > 1)
                    {
                        callback("Duração: \(minutosExtenso) minutos.")
                    }
                    
                    else
                    {
                        callback("Duração: \(minutosExtenso) minuto.")
                    }
                }
                
                else
                {
                    if (minutosExtenso > 1)
                    {
                        callback("Duração: \(minutosExtenso) minutos e \(segundosExtenso) segundos.")
                    }
                    
                    else
                    {
                        callback("Duração: \(minutosExtenso) minuto e \(segundosExtenso) segundos.")
                    }
                }
            }
            
            else
            {
                if (segundosExtenso > 1)
                {
                    callback("Duração: \(segundosExtenso) segundos.")
                }
                
                else
                {
                    callback("Duração: \(segundosExtenso) segundo.")
                }
            }
        }
    }
    
    class CriaObjetos
    {
        var arrayObjetos = [Video]()
        var array: NSArray
        var callback: (NSArray?) -> ()
        
        init(array: NSArray, callback: (NSArray?) -> ())
        {
            self.array = array
            self.callback = callback
            self.criaObjs()
        }
        
        func criaObjs()
        {
            for json in array
            {
                var video = Video()
                
                //Pega a URL do thumb e duração do vídeo
                if let mediagroup = json["media$group"] as? NSDictionary
                {
                    //URL do thumb
                    if let mediathumbnail: NSArray = mediagroup["media$thumbnail"] as? NSArray
                    {
                        if let thumbs: NSDictionary = mediathumbnail[0] as? NSDictionary
                        {
                            if let url = thumbs["url"] as? NSString
                            {
                                //println("Url: \(url)")
                                video.thumb = url
                            }
                        }
                    }
                    
                    //Duraçao
                    if let mediatcontent: NSArray = mediagroup["media$content"] as? NSArray
                    {
                        if let content: NSDictionary = mediatcontent[0] as? NSDictionary
                        {
                            if let duracao = content["duration"] as? NSInteger
                            {
                                //println("Duração: \(duracao)")
                                video.duracao = duracao
                            }
                        }
                    }
                }
                
                //Pega o nome do author
//                if let author: NSArray = json["author"] as? NSArray
//                {
//                    if let content: NSDictionary = author[0] as? NSDictionary
//                    {
//                        if let authorName: NSDictionary = content["name"] as? NSDictionary
//                        {
//                            if let name = authorName["$t"] as? NSString
//                            {
//                                println("Nome: \(name)")
//                                video.titulo = name
//                            }
//                        }
//                    }
//                }
                
                //Pega o nome do vídeo
                if let content: NSDictionary = json["title"] as? NSDictionary
                {
                    if let title = content["$t"] as? NSString
                    {
                        //println("Nome: \(title)")
                        video.titulo = title
                    }
                }
                
                //Pega a descrição do vídeo
                if let content: NSDictionary = json["content"] as? NSDictionary
                {
                    if let descricao = content["$t"] as? NSString
                    {
                        //println("Descrição: \(descricao)")
                        video.descricao = descricao
                    }
                }
                
                //Pega a ID do vídeo
                if let content: NSDictionary = json["id"] as? NSDictionary
                {
                    if let id = content["$t"] as? NSString
                    {
                        let idString: String = id
                        let newString = idString.stringByReplacingOccurrencesOfString("http://gdata.youtube.com/feeds/api/videos/", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
                        //println("Video ID: \(newString)")
                        video.videoId = newString
                    }
                }
                
                //Relacionados
                //http://gdata.youtube.com/feeds/api/videos/1i3VW5KFJX8/related?&alt=json
                if let link: NSArray = json["link"] as? NSArray
                {
                    if let links: NSDictionary = link[1] as? NSDictionary
                    {
                        if let url = links["href"] as? NSString
                        {
                            //println("Video relacionado: \(url)")
                            video.relacionados = url
                        }
                    }
                }

                
                arrayObjetos.insert(video, atIndex: arrayObjetos.count)
            }
            
            if(arrayObjetos.count > 0)
            {
                self.callback(arrayObjetos)
            }
                
            else
            {
                self.callback(nil)
            }
        }
    }
}
