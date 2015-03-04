//
//  AsyncImage.swift
//  iDent
//
//  Created by Vinicius Brito on 03/03/15.
//  Copyright (c) 2015 Vinicius. All rights reserved.

// http://stackoverflow.com/questions/26396301/setting-images-in-uitableviewcell-in-swift

//class AsyncImage
//{
//    var url: String
//    var callback: (NSData?) -> ()
//    
//    init(url: String, callback: (NSData?) -> ())
//    {
//        self.url = url
//        self.callback = callback
//        self.fetch()
//    }
//    
//    func fetch()
//    {
//        var imageRequest: NSURLRequest = NSURLRequest(URL: NSURL(string: self.url)!)
//        NSURLConnection.sendAsynchronousRequest(imageRequest,
//            queue: NSOperationQueue.mainQueue(),
//            completionHandler: { response, data, error in
//                if(error == nil)
//                {
//                    self.callback(data)
//                }
//                
//                else
//                {
//                    self.callback(nil)
//                }
//        })
//        
//        callback(nil)
//    }
//}