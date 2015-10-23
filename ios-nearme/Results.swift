//
//  Results.swift
//  ios-nearme
//
//  Created by Ryan Walton on 10/20/15.
//  Copyright © 2015 Ryan Walton. All rights reserved.
//

import Foundation
import Alamofire

class Networking {
    
    class func getThings() {
        Alamofire.request(.GET, "http://heroku-nearme.herokuapp.com/api/v1/things")
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization

                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
        }
    }
}


var results: JSON = [
    //
    
    [
        "_id": "5612a9d5f3d5e8c440539a0c",
        "slug": "dolores-park-bench-south-west-side",
        "title": "Dolores Park Bench - South West Side",
        "createdAt": "2015-10-05T09:48:21.000Z",
        "__v": 2,
        "superThing": [],
        "description": "This is one of the best benches in all of San Francisco. It sports an amazing view of Dolores park and downtown. There is a Muni stop right there. There is a small downside - sometimes homeless people drink their booze along the benches that line the park.",
        "updatedAt": "2015-10-15T04:19:52.360Z",
        "updatedBy": "561128884d6a896d259c1d9c",
        "publishedAt": "2015-10-11T00:20:53.000Z",
        "location": [],
        "primaryImage": [],
        "category": [],
        "place": [
        [
        "_id": "561b10b2cce4ccad1ef9bbf9",
        "updatedBy": "561128884d6a896d259c1d9c",
        "updatedAt": "2015-10-12T01:53:27.634Z",
        "createdBy": "561128884d6a896d259c1d9c",
        "createdAt": "2015-10-12T01:45:22.099Z",
        "slug": "dolores-park",
        "title": "Dolores Park",
        "__v": 2,
        "description": "One of the most popular parks in the city. Sers.",
        "location": [
        "street1": "455 Dolores St",
        "suburb": "San Francisco",
        "state": "CA",
        "postcode": "94110",
        "geo": [
        -122.42588,
        37.762096
        ],
        "country": "United States"
        ],
        "category": [
        "561aebb558dc613bb4489954",
        "561aebb558dc613bb4489b02"
        ],
        "primaryImage": [
        "filename": "0db5146c6c2c6f958e7b2ac7e91593d1.jpg",
        "originalname": "Dolores_Park,_San_Francisco_2013-04-13_14-48.jpg",
        "path": "",
        "size": 1269264,
        "filetype": "image/jpeg",
        "url": "//heroku-nearme.s3.amazonaws.com/0db5146c6c2c6f958e7b2ac7e91593d1.jpg"
        ],
        "state": "draft"
        ]
        ],
        "state": "published"
    ],
    [
        "_id": "56182e1decd1d803006a6224",
        "slug": "thermal-underwear",
        "title": "Thermal Underwear",
        "createdAt": "2015-10-09T14:14:05.000Z",
        "__v": 1,
        "author": "561128654d6a896d259c1d9a",
        "description": "",
        "updatedAt": "2015-10-16T17:15:58.627Z",
        "updatedBy": "561128884d6a896d259c1d9c",
        "superThing": "",
        "location": [
            "postcode": "",
            "state": "",
            "street1": "",
            "suburb": "",
            "country": "United States"
        ],
        "category": [
        [
        "_id": "561f0e6a58dc613bb44943d1",
        "slug": "underwear",
        "title": "Underwear",
        "parents": [
        "561f0e6a58dc613bb449450c"
        ]
        ]
        ],
        "place": [
        [
        "_id": "56181fa1ecd1d803006a6222",
        "slug": "franks-market-and-liquors",
        "title": "Frank's Market & Liquors",
        "createdAt": "2015-10-08T09:12:17.000Z",
        "__v": 10,
        "author": "56183504ecd1d803006a6227",
        "description": "",
        "updatedAt": "2015-10-22T16:46:45.106Z",
        "updatedBy": "561128884d6a896d259c1d9c",
        "thing": [
        "56183e08ecd1d803006a622b",
        "56183652ecd1d803006a6228",
        "561836f9ecd1d803006a622a",
        "56182e1decd1d803006a6224"
        ],
        "location": [
        "geo": [
        -122.43698,
        37.72158
        ],
        "name": "",
        "number": "",
        "postcode": "",
        "state": "",
        "street1": "4799 Mission St",
        "street2": "",
        "suburb": "",
        "country": "United States"
        ],
        "category": [
        "561aebb458dc613bb4489898",
        "561aebb458dc613bb4489883"
        ],
        "primaryImage": [
        "filename": "0513d61a1b0c0feca509af56239e1f4f.jpg",
        "originalname": "6a21b27584d41ab8e0361b15560a7b41.jpg",
        "path": "",
        "size": 26086,
        "filetype": "image/jpeg",
        "url": "//heroku-nearme.s3.amazonaws.com/0513d61a1b0c0feca509af56239e1f4f.jpg"
        ],
        "state": "published"
        ]
        ],
        "state": "published"
    ],
    [
        "_id": "56183652ecd1d803006a6228",
        "slug": "c-batteries",
        "title": "C batteries",
        "createdAt": "2015-10-09T07:49:06.000Z",
        "__v": 2,
        "author": "56183504ecd1d803006a6227",
        "description": "",
        "superThing": [
            "_id": "561836d3ecd1d803006a6229",
            "slug": "batteries",
            "title": "Batteries",
            "createdAt": "2015-10-09T14:51:15.000Z",
            "__v": 0,
            "state": "published"
        ],
        "updatedAt": "2015-10-15T04:09:56.266Z",
        "updatedBy": "561128884d6a896d259c1d9c",
        "location": [
            "postcode": "",
            "state": "",
            "street1": "",
            "suburb": "",
            "country": "United States"
        ],
        "category": [
        [
        "_id": "561f0e6958dc613bb4493b31",
        "slug": "batteries",
        "title": "Batteries",
        "parents": [
        "561f0e6a58dc613bb4494637"
        ]
        ]
        ],
        "place": [
        [
        "_id": "56181fa1ecd1d803006a6222",
        "slug": "franks-market-and-liquors",
        "title": "Frank's Market & Liquors",
        "createdAt": "2015-10-08T09:12:17.000Z",
        "__v": 10,
        "author": "56183504ecd1d803006a6227",
        "description": "",
        "updatedAt": "2015-10-22T16:46:45.106Z",
        "updatedBy": "561128884d6a896d259c1d9c",
        "thing": [
        "56183e08ecd1d803006a622b",
        "56183652ecd1d803006a6228",
        "561836f9ecd1d803006a622a",
        "56182e1decd1d803006a6224"
        ],
        "location": [
        "geo": [
        -122.43698,
        37.72158
        ],
        "name": "",
        "number": "",
        "postcode": "",
        "state": "",
        "street1": "4799 Mission St",
        "street2": "",
        "suburb": "",
        "country": "United States"
        ],
        "category": [
        "561aebb458dc613bb4489898",
        "561aebb458dc613bb4489883"
        ],
        "primaryImage": [
        "filename": "0513d61a1b0c0feca509af56239e1f4f.jpg",
        "originalname": "6a21b27584d41ab8e0361b15560a7b41.jpg",
        "path": "",
        "size": 26086,
        "filetype": "image/jpeg",
        "url": "//heroku-nearme.s3.amazonaws.com/0513d61a1b0c0feca509af56239e1f4f.jpg"
        ],
        "state": "published"
        ],
        [
        "_id": "561829b4ecd1d803006a6223",
        "slug": "mi-tierrita",
        "title": "Mi Tierrita",
        "createdAt": "2015-10-08T23:55:16.000Z",
        "__v": 5,
        "description": "Mexican market. Fruits, veggies. Usually very inexpensive.",
        "updatedAt": "2015-10-12T00:19:56.394Z",
        "updatedBy": "561128884d6a896d259c1d9c",
        "location": [
        "geo": [
        -122.43899,
        37.721706
        ],
        "name": "",
        "number": "",
        "postcode": "",
        "state": "",
        "street1": "4791 Mission St",
        "street2": "",
        "suburb": "",
        "country": "United States"
        ],
        "category": [
        "561aebb558dc613bb44899db",
        "561aebb558dc613bb4489a96",
        "561aebb558dc613bb4489a89"
        ],
        "primaryImage": [
        "filename": "6779db49218f00b0c16d7662dcdb0fa1.jpg",
        "originalname": "d256c9a860a5e7990ee67879c095f8df.jpg",
        "path": "",
        "size": 31645,
        "filetype": "image/jpeg",
        "url": "//heroku-nearme.s3.amazonaws.com/6779db49218f00b0c16d7662dcdb0fa1.jpg"
        ],
        "state": "published"
        ]
        ],
        "state": "draft"
    ],
    [
        "_id": "561836f9ecd1d803006a622a",
        "slug": "aa-batteries",
        "title": "AA batteries",
        "createdAt": "2015-10-09T14:51:53.000Z",
        "__v": 2,
        "description": "Pack of 4.",
        "superThing": [
            "_id": "561836d3ecd1d803006a6229",
            "slug": "batteries",
            "title": "Batteries",
            "createdAt": "2015-10-09T14:51:15.000Z",
            "__v": 0,
            "state": "published"
        ],
        "updatedAt": "2015-10-16T17:00:02.040Z",
        "updatedBy": "561128884d6a896d259c1d9c",
        "location": [
            "postcode": "",
            "state": "",
            "street1": "",
            "suburb": "",
            "country": "United States"
        ],
        "category": [
        [
        "_id": "561f0e6958dc613bb4493b31",
        "slug": "batteries",
        "title": "Batteries",
        "parents": [
        "561f0e6a58dc613bb4494637"
        ]
        ]
        ],
        "place": [
        [
        "_id": "56181fa1ecd1d803006a6222",
        "slug": "franks-market-and-liquors",
        "title": "Frank's Market & Liquors",
        "createdAt": "2015-10-08T09:12:17.000Z",
        "__v": 10,
        "author": "56183504ecd1d803006a6227",
        "description": "",
        "updatedAt": "2015-10-22T16:46:45.106Z",
        "updatedBy": "561128884d6a896d259c1d9c",
        "thing": [
        "56183e08ecd1d803006a622b",
        "56183652ecd1d803006a6228",
        "561836f9ecd1d803006a622a",
        "56182e1decd1d803006a6224"
        ],
        "location": [
        "geo": [
        -122.43698,
        37.72158
        ],
        "name": "",
        "number": "",
        "postcode": "",
        "state": "",
        "street1": "4799 Mission St",
        "street2": "",
        "suburb": "",
        "country": "United States"
        ],
        "category": [
        "561aebb458dc613bb4489898",
        "561aebb458dc613bb4489883"
        ],
        "primaryImage": [
        "filename": "0513d61a1b0c0feca509af56239e1f4f.jpg",
        "originalname": "6a21b27584d41ab8e0361b15560a7b41.jpg",
        "path": "",
        "size": 26086,
        "filetype": "image/jpeg",
        "url": "//heroku-nearme.s3.amazonaws.com/0513d61a1b0c0feca509af56239e1f4f.jpg"
        ],
        "state": "published"
        ],
        [
        "_id": "561829b4ecd1d803006a6223",
        "slug": "mi-tierrita",
        "title": "Mi Tierrita",
        "createdAt": "2015-10-08T23:55:16.000Z",
        "__v": 5,
        "description": "Mexican market. Fruits, veggies. Usually very inexpensive.",
        "updatedAt": "2015-10-12T00:19:56.394Z",
        "updatedBy": "561128884d6a896d259c1d9c",
        "location": [
        "geo": [
        -122.43899,
        37.721706
        ],
        "name": "",
        "number": "",
        "postcode": "",
        "state": "",
        "street1": "4791 Mission St",
        "street2": "",
        "suburb": "",
        "country": "United States"
        ],
        "category": [
        "561aebb558dc613bb44899db",
        "561aebb558dc613bb4489a96",
        "561aebb558dc613bb4489a89"
        ],
        "primaryImage": [
        "filename": "6779db49218f00b0c16d7662dcdb0fa1.jpg",
        "originalname": "d256c9a860a5e7990ee67879c095f8df.jpg",
        "path": "",
        "size": 31645,
        "filetype": "image/jpeg",
        "url": "//heroku-nearme.s3.amazonaws.com/6779db49218f00b0c16d7662dcdb0fa1.jpg"
        ],
        "state": "published"
        ]
        ],
        "state": "draft"
    ],
    [
        "_id": "56118535c3a2d02d380f3a35",
        "slug": "mclaren-park-bench-east-side",
        "title": "McLaren Park Bench - East Side",
        "createdAt": "2015-10-04T19:59:49.000Z",
        "__v": 5,
        "superThing": [
            "_id": "561184d4c3a2d02d380f3a34",
            "slug": "bench",
            "title": "Bench",
            "createdAt": "2015-10-04T19:58:12.000Z",
            "__v": 0,
            "state": "draft"
        ],
        "description": "",
        "updatedAt": "2015-10-16T17:00:15.510Z",
        "updatedBy": "561128884d6a896d259c1d9c",
        "location": [
            "name": "",
            "number": "",
            "postcode": "",
            "state": "",
            "street1": "",
            "street2": "",
            "suburb": "",
            "geo": [
            -122.43259,
            37.71387
            ],
            "country": "United States"
        ],
        "primaryImage": [
            "filename": "b25216de2690bb54e656bd3e488bde1b.jpg",
            "originalname": "aphilosophersway.jpg",
            "path": "",
            "size": 99084,
            "filetype": "image/jpeg",
            "url": "//heroku-nearme.s3.amazonaws.com/b25216de2690bb54e656bd3e488bde1b.jpg"
        ],
        "category": [
        [
        "_id": "561f0e6a58dc613bb4494a24",
        "slug": "benches",
        "title": "Benches",
        "parents": [
        "561f0e6a58dc613bb4494adb"
        ]
        ],
        [
        "_id": "561f0e6958dc613bb449408c",
        "slug": "outdoor-benches",
        "title": "Outdoor Benches",
        "parents": [
        "561f0e6a58dc613bb44946bf"
        ]
        ]
        ],
        "place": [
        [
        "_id": "56194359b9ba90530ba7966f",
        "slug": "crocker-amazon-park",
        "title": "Crocker Amazon Park",
        "createdAt": "2015-10-10T16:56:57.000Z",
        "__v": 2,
        "description": "Main park in the southern part of San Francisco, in the Excelsior District. Lots of playing fields.",
        "updatedAt": "2015-10-12T01:48:29.331Z",
        "updatedBy": "561128884d6a896d259c1d9c",
        "location": [
        "street1": "799 Moscow St",
        "suburb": "San Francisco",
        "state": "CA",
        "postcode": "94112",
        "geo": [
        -122.43044,
        37.71449
        ],
        "country": "United States"
        ],
        "category": [
        "561aebb558dc613bb4489954",
        "561aebb558dc613bb4489b02"
        ],
        "primaryImage": [
        "filename": "1f82d8e987df086d0b17b22b37c6403e.jpg",
        "originalname": "Crocker-Amazon-Park.jpg",
        "path": "",
        "size": 233852,
        "filetype": "image/jpeg",
        "url": "//heroku-nearme.s3.amazonaws.com/1f82d8e987df086d0b17b22b37c6403e.jpg"
        ],
        "state": "published"
        ]
        ],
        "state": "draft"
    ],
    [
        "_id": "5615d8d366d0a9e00924a88c",
        "slug": "four-barrel-cup-of-coffee",
        "title": "Four Barrel Cup of Coffee",
        "createdAt": "2015-10-08T02:45:39.000Z",
        "__v": 2,
        "author": "561128884d6a896d259c1d9c",
        "description": "One of the best cups of coffee in the city! Brewed to perfection. They also have a nice coffee making class, but that's beyond a cup of coffee :)",
        "superThing": [
            "_id": "5615d91d66d0a9e00924a88d",
            "slug": "coffee-shop",
            "title": "Coffee shop",
            "createdAt": "2015-10-07T19:46:53.000Z",
            "__v": 0,
            "author": "561128884d6a896d259c1d9c",
            "state": "published"
        ],
        "updatedAt": "2015-10-16T17:00:57.490Z",
        "updatedBy": "561128884d6a896d259c1d9c",
        "location": [
            "postcode": "",
            "state": "",
            "street1": "",
            "suburb": "",
            "country": "United States"
        ],
        "primaryImage": [
            "filename": "1b9099e4f1558e7ef6714115574552b4.jpg",
            "originalname": "four-barrel-coffee-flickr-photo-sharing.jpg",
            "path": "",
            "size": 82555,
            "filetype": "image/jpeg",
            "url": "//heroku-nearme.s3.amazonaws.com/1b9099e4f1558e7ef6714115574552b4.jpg"
        ],
        "category": [
        [
        "_id": "561f0e6a58dc613bb44948fc",
        "slug": "coffee",
        "title": "Coffee",
        "parents": [
        "561f0e6a58dc613bb4494a25"
        ]
        ]
        ],
        "place": [
        [
        "_id": "561185f0a8b16749387217f7",
        "slug": "coffee-bar",
        "title": "Coffee Bar",
        "createdAt": "2015-10-04T13:02:56.000Z",
        "__v": 6,
        "places": [
        "5615d9e398f3fa100a7e7dda"
        ],
        "description": "",
        "updatedAt": "2015-10-12T00:18:40.236Z",
        "updatedBy": "561128884d6a896d259c1d9c",
        "location": [
        "name": "",
        "number": "",
        "postcode": "94112",
        "state": "CA",
        "street1": "1890 Bryant St.",
        "street2": "",
        "suburb": "San Francisco",
        "geo": [
        -122.41124,
        37.76425
        ],
        "country": "United States"
        ],
        "category": [
        "561aebb558dc613bb4489907",
        "561aebb558dc613bb4489908",
        "561aebb558dc613bb448990a"
        ],
        "primaryImage": [
        "filename": "1c41dc5b3799ac0e63cae57b3c6fe579.jpg",
        "originalname": "workguide_0174.jpg",
        "path": "",
        "size": 287879,
        "filetype": "image/jpeg",
        "url": "//heroku-nearme.s3.amazonaws.com/1c41dc5b3799ac0e63cae57b3c6fe579.jpg"
        ],
        "state": "published"
        ]
        ],
        "state": "draft"
    ],
    [
        "_id": "56183e08ecd1d803006a622b",
        "slug": "atm",
        "title": "ATM",
        "createdAt": "2015-10-09T15:22:00.000Z",
        "__v": 1,
        "description": "",
        "superThing": [
            "_id": "562131e1d35fac7e16c41052",
            "updatedBy": "561128884d6a896d259c1d9c",
            "updatedAt": "2015-10-16T17:21:05.635Z",
            "createdBy": "561128884d6a896d259c1d9c",
            "createdAt": "2015-10-16T17:20:33.126Z",
            "slug": "atm",
            "title": "ATM",
            "__v": 0,
            "description": "Place to get money.",
            "state": "draft"
        ],
        "updatedAt": "2015-10-16T17:21:34.696Z",
        "updatedBy": "561128884d6a896d259c1d9c",
        "location": [
            "postcode": "",
            "state": "",
            "street1": "",
            "suburb": "",
            "country": "United States"
        ],
        "category": "",
        "place": [
        [
        "_id": "56181fa1ecd1d803006a6222",
        "slug": "franks-market-and-liquors",
        "title": "Frank's Market & Liquors",
        "createdAt": "2015-10-08T09:12:17.000Z",
        "__v": 10,
        "author": "56183504ecd1d803006a6227",
        "description": "",
        "updatedAt": "2015-10-22T16:46:45.106Z",
        "updatedBy": "561128884d6a896d259c1d9c",
        "thing": [
        "56183e08ecd1d803006a622b",
        "56183652ecd1d803006a6228",
        "561836f9ecd1d803006a622a",
        "56182e1decd1d803006a6224"
        ],
        "location": [
        "geo": [
        -122.43698,
        37.72158
        ],
        "name": "",
        "number": "",
        "postcode": "",
        "state": "",
        "street1": "4799 Mission St",
        "street2": "",
        "suburb": "",
        "country": "United States"
        ],
        "category": [
        "561aebb458dc613bb4489898",
        "561aebb458dc613bb4489883"
        ],
        "primaryImage": [
        "filename": "0513d61a1b0c0feca509af56239e1f4f.jpg",
        "originalname": "6a21b27584d41ab8e0361b15560a7b41.jpg",
        "path": "",
        "size": 26086,
        "filetype": "image/jpeg",
        "url": "//heroku-nearme.s3.amazonaws.com/0513d61a1b0c0feca509af56239e1f4f.jpg"
        ],
        "state": "published"
        ]
        ],
        "state": "draft"
    ],
    [
        "_id": "56169ffb35ce5f1b038cf38c",
        "slug": "mclaren-park-bench-south-side",
        "title": "McLaren Park bench - South Side",
        "createdAt": "2015-10-08T16:55:23.000Z",
        "__v": 2,
        "description": "This bench is really cool, too!",
        "superThing": [
            "_id": "561184d4c3a2d02d380f3a34",
            "slug": "bench",
            "title": "Bench",
            "createdAt": "2015-10-04T19:58:12.000Z",
            "__v": 0,
            "state": "draft"
        ],
        "updatedAt": "2015-10-16T17:00:28.480Z",
        "updatedBy": "561128884d6a896d259c1d9c",
        "location": [
            "postcode": "",
            "state": "",
            "street1": "",
            "suburb": "",
            "country": "United States"
        ],
        "primaryImage": [
            "filename": "1bc2cf721b34838a4d3d62b2acbad5a0.jpg",
            "originalname": "628x471.jpg",
            "path": "",
            "size": 71450,
            "filetype": "image/jpeg",
            "url": "//heroku-nearme.s3.amazonaws.com/1bc2cf721b34838a4d3d62b2acbad5a0.jpg"
        ],
        "category": [
        [
        "_id": "561f0e6a58dc613bb4494a24",
        "slug": "benches",
        "title": "Benches",
        "parents": [
        "561f0e6a58dc613bb4494adb"
        ]
        ],
        [
        "_id": "561f0e6958dc613bb449408c",
        "slug": "outdoor-benches",
        "title": "Outdoor Benches",
        "parents": [
        "561f0e6a58dc613bb44946bf"
        ]
        ]
        ],
        "place": [
        [
        "_id": "56194359b9ba90530ba7966f",
        "slug": "crocker-amazon-park",
        "title": "Crocker Amazon Park",
        "createdAt": "2015-10-10T16:56:57.000Z",
        "__v": 2,
        "description": "Main park in the southern part of San Francisco, in the Excelsior District. Lots of playing fields.",
        "updatedAt": "2015-10-12T01:48:29.331Z",
        "updatedBy": "561128884d6a896d259c1d9c",
        "location": [
        "street1": "799 Moscow St",
        "suburb": "San Francisco",
        "state": "CA",
        "postcode": "94112",
        "geo": [
        -122.43044,
        37.71449
        ],
        "country": "United States"
        ],
        "category": [
        "561aebb558dc613bb4489954",
        "561aebb558dc613bb4489b02"
        ],
        "primaryImage": [
        "filename": "1f82d8e987df086d0b17b22b37c6403e.jpg",
        "originalname": "Crocker-Amazon-Park.jpg",
        "path": "",
        "size": 233852,
        "filetype": "image/jpeg",
        "url": "//heroku-nearme.s3.amazonaws.com/1f82d8e987df086d0b17b22b37c6403e.jpg"
        ],
        "state": "published"
        ]
        ],
        "state": "draft"
    ],
    [
        "_id": "561c230604952b0300a0c492",
        "updatedBy": "561128884d6a896d259c1d9c",
        "updatedAt": "2015-10-16T16:59:52.384Z",
        "createdBy": "561128884d6a896d259c1d9c",
        "createdAt": "2015-10-12T21:15:50.841Z",
        "slug": "lower-level-dolores-park-bench",
        "title": "Lower Level Dolores Park Bench",
        "__v": 2,
        "description": "This is the lower level bench at Dolores Park. It's pretty cool.",
        "superThing": "",
        "location": [
            "postcode": "",
            "state": "",
            "street1": "",
            "suburb": "",
            "country": "United States"
        ],
        "primaryImage": [
            "filename": "20c322fd47da2d8a30ffdbf64e30a401.jpg",
            "originalname": "newdolorespark7.jpg",
            "path": "",
            "size": 113397,
            "filetype": "image/jpeg",
            "url": "//heroku-nearme.s3.amazonaws.com/20c322fd47da2d8a30ffdbf64e30a401.jpg"
        ],
        "category": [
        [
        "_id": "561f0e6a58dc613bb4494a24",
        "slug": "benches",
        "title": "Benches",
        "parents": [
        "561f0e6a58dc613bb4494adb"
        ]
        ],
        [
        "_id": "561f0e6958dc613bb449408c",
        "slug": "outdoor-benches",
        "title": "Outdoor Benches",
        "parents": [
        "561f0e6a58dc613bb44946bf"
        ]
        ]
        ],
        "place": [
        [
        "_id": "561b10b2cce4ccad1ef9bbf9",
        "updatedBy": "561128884d6a896d259c1d9c",
        "updatedAt": "2015-10-12T01:53:27.634Z",
        "createdBy": "561128884d6a896d259c1d9c",
        "createdAt": "2015-10-12T01:45:22.099Z",
        "slug": "dolores-park",
        "title": "Dolores Park",
        "__v": 2,
        "description": "One of the most popular parks in the city. Sers.",
        "location": [
        "street1": "455 Dolores St",
        "suburb": "San Francisco",
        "state": "CA",
        "postcode": "94110",
        "geo": [
        -122.42588,
        37.762096
        ],
        "country": "United States"
        ],
        "category": [
        "561aebb558dc613bb4489954",
        "561aebb558dc613bb4489b02"
        ],
        "primaryImage": [
        "filename": "0db5146c6c2c6f958e7b2ac7e91593d1.jpg",
        "originalname": "Dolores_Park,_San_Francisco_2013-04-13_14-48.jpg",
        "path": "",
        "size": 1269264,
        "filetype": "image/jpeg",
        "url": "//heroku-nearme.s3.amazonaws.com/0db5146c6c2c6f958e7b2ac7e91593d1.jpg"
        ],
        "state": "draft"
        ]
        ],
        "state": "published"
    ],
    [
        "_id": "5615d9e398f3fa100a7e7dda",
        "slug": "nice-space-to-work-on-an-idea",
        "title": "Nice Space to Work on an Idea",
        "createdAt": "2015-10-08T02:50:11.000Z",
        "__v": 1,
        "author": "561128884d6a896d259c1d9c",
        "description": "Coffee Bar is not necessarily a chill place to work - it's usually pretty busy. But it is *the* spot to work on your next great big idea.",
        "superThing": [
            "_id": "5615da7198f3fa100a7e7ddb",
            "slug": "workspace",
            "title": "Workspace",
            "createdAt": "2015-10-08T02:52:33.404Z",
            "__v": 0,
            "state": "draft"
        ],
        "updatedAt": "2015-10-16T17:02:51.694Z",
        "updatedBy": "561128884d6a896d259c1d9c",
        "location": [
            "postcode": "",
            "state": "",
            "street1": "",
            "suburb": "",
            "country": "United States"
        ],
        "category": [
        [
        "_id": "561f0e6a58dc613bb44944aa",
        "slug": "workspace-tables",
        "title": "Workspace Tables",
        "parents": [
        "561f0e6a58dc613bb4494a92"
        ]
        ]
        ],
        "place": [
        [
        "_id": "561185f0a8b16749387217f7",
        "slug": "coffee-bar",
        "title": "Coffee Bar",
        "createdAt": "2015-10-04T13:02:56.000Z",
        "__v": 6,
        "places": [
        "5615d9e398f3fa100a7e7dda"
        ],
        "description": "",
        "updatedAt": "2015-10-12T00:18:40.236Z",
        "updatedBy": "561128884d6a896d259c1d9c",
        "location": [
        "name": "",
        "number": "",
        "postcode": "94112",
        "state": "CA",
        "street1": "1890 Bryant St.",
        "street2": "",
        "suburb": "San Francisco",
        "geo": [
        -122.41124,
        37.76425
        ],
        "country": "United States"
        ],
        "category": [
        "561aebb558dc613bb4489907",
        "561aebb558dc613bb4489908",
        "561aebb558dc613bb448990a"
        ],
        "primaryImage": [
        "filename": "1c41dc5b3799ac0e63cae57b3c6fe579.jpg",
        "originalname": "workguide_0174.jpg",
        "path": "",
        "size": 287879,
        "filetype": "image/jpeg",
        "url": "//heroku-nearme.s3.amazonaws.com/1c41dc5b3799ac0e63cae57b3c6fe579.jpg"
        ],
        "state": "published"
        ]
        ],
        "state": "draft"
    ]
    //
]
