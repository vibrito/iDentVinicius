//
//  Service.swift
//  iDent
//
//  Created by Vinicius Brito on 03/03/15.
//  Copyright (c) 2015 Vinicius. All rights reserved.
//

class Service
{
    let manager = AFHTTPRequestOperationManager()
    var url: String
    var callback: (NSArray?) -> ()
    
    init(url: String, callback: (NSArray?) -> ())
    {
        self.url = url
        self.callback = callback
        self.fetch()
    }
    
    func fetch()
    {
        var parameters = [ "alt":"json/xml", "start-index":"0", "max-results":"1"]
        manager.responseSerializer = AFJSONResponseSerializer()
        manager.GET( url,
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                
                if let topApps = responseObject as? NSDictionary
                {
                    if let feed = topApps["feed"] as? NSDictionary
                    {
                        if let apps = feed["entry"] as? NSArray
                        {
                            //println("Lista de vídeos: \(apps)")
                            self.callback(apps)
                        }
                    }
                }
            },
            
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                println("error: \(error)")
                self.callback(nil)
        })
    }
}
