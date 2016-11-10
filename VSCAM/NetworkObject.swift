

import UIKit

class PhotoObject {

    var pid: Int?       //照片 id
    var uid: Int?       //用户 id
    var origin: String? //原始图片 id
    var scale: Double?  //图像比例 宽/高
    var wbpid: String?  //微博图片 id
    var preset: String? //滤镜名称 字符串
    var unix: Int64?    //发布时间

    //extern
    var owner: UserObject?

    init?(_ dict: NSDictionary?) {
        if let tryDict = dict {
            pid = Int.fromJson(tryDict.value(forKey: "pid"))
            uid = Int.fromJson(tryDict.value(forKey: "uid"))
            origin = String.fromJson(tryDict.value(forKey: "origin"))
            scale = Double.fromJson(tryDict.value(forKey: "scale"))
            wbpid = String.fromJson(tryDict.value(forKey: "wbpid"))
            preset = String.fromJson(tryDict.value(forKey: "preset"))
            unix = Int64.fromJson(tryDict.value(forKey: "unix"))
        } else {
            return nil
        }
    }
}

class UserObject {

    var uid: Int?       //用户 id
    var name: String?   //用户名
    var avatar: Int?    //用户头像 id

    init?(_ dict: NSDictionary?) {
        if let tryDict = dict {
            uid = Int.fromJson(tryDict.value(forKey: "uid"))
            name = String.fromJson(tryDict.value(forKey: "name"))
            avatar = Int.fromJson(tryDict.value(forKey: "avatar"))
        } else {
            return nil
        }
    }
}

class ImageListObject {

    var grids: [PhotoObject]?   //照片们
    var users: [UserObject]?    //用户们

    init?(_ dict: AnyObject?) {
        if let tryDict = dict as? NSDictionary {
            if let dataList = tryDict["users"] as? NSArray {
                var tempList = [UserObject]()
                for data in dataList {
                    if let tryObject = UserObject(data as? NSDictionary) {
                        tempList.append(tryObject)
                    }
                }
                users = tempList
            }
            if let dataList = tryDict["grids"] as? NSArray {
                var tempList = [PhotoObject]()
                for data in dataList {
                    if let tryObject = PhotoObject(data as? NSDictionary) {
                        if let tryUID = tryObject.uid {
                            tryObject.owner = getUserBy(UID: tryUID)
                        }
                        tempList.append(tryObject)
                    }
                }
                grids = tempList
            }
        } else {
            return nil
        }
    }

    func getUserBy(UID: Int) -> UserObject? {
        if let tryUsers = users {
            for user in tryUsers {
                if user.uid == UID {
                    return user
                }
            }
        }
        return nil
    }

    func append(newObject: ImageListObject) {
        var finalNewImageList = [PhotoObject]()
        if let tryNewImageList = newObject.grids, let tryOldImageList = grids {
            for newImage in tryNewImageList {
                var markHas = false
                for oldImage in tryOldImageList {
                    if oldImage.pid == newImage.pid {
                        markHas = true
                        break
                    }
                }
                if markHas == false {
                    finalNewImageList.append(newImage)
                }
            }
            grids?.append(contentsOf: finalNewImageList)
        }

        var finalNewUserList = [UserObject]()
        if let tryNewUserList = newObject.users, let tryOldUserList = users {
            for newUser in tryNewUserList {
                var markHas = false
                for oldUser in tryOldUserList {
                    if oldUser.uid == newUser.uid {
                        markHas = true
                        break
                    }
                }
                if markHas == false {
                    finalNewUserList.append(newUser)
                }
            }
            users?.append(contentsOf: finalNewUserList)
        }
    }
}

class COMPUTEDObject {

    var html: String?
    var Height: Int?
    var Width: Int?
    var IsColor: Int?
    var ByteOrderMotorola: Int?
    var ApertureFNumber: String?
    var Thumbnail_FileType: Int?
    var Thumbnail_MimeType: String?

    init?(_ dict: NSDictionary?) {
        if let tryDict = dict {
            html = String.fromJson(tryDict.value(forKey: "html"))
            Height = Int.fromJson(tryDict.value(forKey: "Height"))
            Width = Int.fromJson(tryDict.value(forKey: "Width"))
            IsColor = Int.fromJson(tryDict.value(forKey: "IsColor"))
            ByteOrderMotorola = Int.fromJson(tryDict.value(forKey: "ByteOrderMotorola"))
            ApertureFNumber = String.fromJson(tryDict.value(forKey: "ApertureFNumber"))
            Thumbnail_FileType = Int.fromJson(tryDict.value(forKey: "Thumbnail.FileType"))
            Thumbnail_MimeType = String.fromJson(tryDict.value(forKey: "Thumbnail.MimeType"))
        } else {
            return nil
        }
    }
}

class IFD0Object {

    var ImageWidth: Int?
    var ImageLength: Int?
    var BitsPerSample: [Int]?
    var PhotometricInterpretation: Int?
    var ImageDescription: String?
    var Make: String?
    var Model: String?
    var Orientation: Int?
    var SamplesPerPixel: Int?
    var XResolution: String?
    var YResolution: String?
    var ResolutionUnit: Int?
    var Software: String?
    var DateTime: String?
    var Exif_IFD_Pointer: Int?
    var GPS_IFD_Pointer: Int?

    init?(_ dict: NSDictionary?) {
        if let tryDict = dict {
            ImageWidth = Int.fromJson(tryDict.value(forKey: "ImageWidth"))
            ImageLength = Int.fromJson(tryDict.value(forKey: "ImageLength"))
            if let dataList = tryDict["BitsPerSample"] as? NSArray {
                var tempList = [Int]()
                for data in dataList {
                    if let tryObject = Int.fromJson(data) {
                        tempList.append(tryObject)
                    }
                }
                BitsPerSample = tempList
            }
            PhotometricInterpretation = Int.fromJson(tryDict.value(forKey: "PhotometricInterpretation"))
            ImageDescription = String.fromJson(tryDict.value(forKey: "ImageDescription"))
            Make = String.fromJson(tryDict.value(forKey: "Make"))
            Model = String.fromJson(tryDict.value(forKey: "Model"))
            Orientation = Int.fromJson(tryDict.value(forKey: "Orientation"))
            SamplesPerPixel = Int.fromJson(tryDict.value(forKey: "SamplesPerPixel"))
            XResolution = String.fromJson(tryDict.value(forKey: "XResolution"))
            YResolution = String.fromJson(tryDict.value(forKey: "YResolution"))
            ResolutionUnit = Int.fromJson(tryDict.value(forKey: "ResolutionUnit"))
            Software = String.fromJson(tryDict.value(forKey: "Software"))
            DateTime = String.fromJson(tryDict.value(forKey: "DateTime"))
            Exif_IFD_Pointer = Int.fromJson(tryDict.value(forKey: "Exif_IFD_Pointer"))
            GPS_IFD_Pointer = Int.fromJson(tryDict.value(forKey: "GPS_IFD_Pointer"))
        } else {
            return nil
        }
    }
}

class EXIFObject {

    var ExposureTime: String?
    var FNumber: String?
    var ExposureProgram: Int?
    var ISOSpeedRatings: Int?
    var ExifVersion: String?
    var DateTimeOriginal: String?
    var DateTimeDigitized: String?
    var ComponentsConfiguration: String?
    var ShutterSpeedValue: String?
    var ApertureValue: String?
    var BrightnessValue: String?
    var ExposureBiasValue: String?
    var MeteringMode: Int?
    var Flash: Int?
    var FocalLength: String?
    var SubjectLocation: [Int]?
    var SubSecTimeOriginal: String?
    var SubSecTimeDigitized: String?
    var FlashPixVersion: String?
    var ColorSpace: Int?
    var ExifImageWidth: Int?
    var ExifImageLength: Int?
    var SensingMethod: Int?
    var SceneType: String?
    var ExposureMode: Int?
    var WhiteBalance: Int?
    var FocalLengthIn35mmFilm: Int?
    var SceneCaptureType: Int?
    var UndefinedTag_0xA432: [String]?
    var UndefinedTag_0xA433: String?
    var UndefinedTag_0xA434: String?

    init?(_ dict: NSDictionary?) {
        if let tryDict = dict {
            ExposureTime = String.fromJson(tryDict.value(forKey: "ExposureTime"))
            FNumber = String.fromJson(tryDict.value(forKey: "FNumber"))
            ExposureProgram = Int.fromJson(tryDict.value(forKey: "ExposureProgram"))
            ISOSpeedRatings = Int.fromJson(tryDict.value(forKey: "ISOSpeedRatings"))
            ExifVersion = String.fromJson(tryDict.value(forKey: "ExifVersion"))
            DateTimeOriginal = String.fromJson(tryDict.value(forKey: "DateTimeOriginal"))
            DateTimeDigitized = String.fromJson(tryDict.value(forKey: "DateTimeDigitized"))
            ComponentsConfiguration = String.fromJson(tryDict.value(forKey: "ComponentsConfiguration"))
            ShutterSpeedValue = String.fromJson(tryDict.value(forKey: "ShutterSpeedValue"))
            ApertureValue = String.fromJson(tryDict.value(forKey: "ApertureValue"))
            BrightnessValue = String.fromJson(tryDict.value(forKey: "BrightnessValue"))
            ExposureBiasValue = String.fromJson(tryDict.value(forKey: "ExposureBiasValue"))
            MeteringMode = Int.fromJson(tryDict.value(forKey: "MeteringMode"))
            Flash = Int.fromJson(tryDict.value(forKey: "Flash"))
            FocalLength = String.fromJson(tryDict.value(forKey: "FocalLength"))
            if let dataList = tryDict["SubjectLocation"] as? NSArray {
                var tempList = [Int]()
                for data in dataList {
                    if let tryObject = Int.fromJson(data) {
                        tempList.append(tryObject)
                    }
                }
                SubjectLocation = tempList
            }
            SubSecTimeOriginal = String.fromJson(tryDict.value(forKey: "SubSecTimeOriginal"))
            SubSecTimeDigitized = String.fromJson(tryDict.value(forKey: "SubSecTimeDigitized"))
            FlashPixVersion = String.fromJson(tryDict.value(forKey: "FlashPixVersion"))
            ColorSpace = Int.fromJson(tryDict.value(forKey: "ColorSpace"))
            ExifImageWidth = Int.fromJson(tryDict.value(forKey: "ExifImageWidth"))
            ExifImageLength = Int.fromJson(tryDict.value(forKey: "ExifImageLength"))
            SensingMethod = Int.fromJson(tryDict.value(forKey: "SensingMethod"))
            SceneType = String.fromJson(tryDict.value(forKey: "SceneType"))
            ExposureMode = Int.fromJson(tryDict.value(forKey: "ExposureMode"))
            WhiteBalance = Int.fromJson(tryDict.value(forKey: "WhiteBalance"))
            FocalLengthIn35mmFilm = Int.fromJson(tryDict.value(forKey: "FocalLengthIn35mmFilm"))
            SceneCaptureType = Int.fromJson(tryDict.value(forKey: "SceneCaptureType"))
            if let dataList = tryDict["UndefinedTag:0xA432"] as? NSArray {
                var tempList = [String]()
                for data in dataList {
                    if let tryObject = String.fromJson(data) {
                        tempList.append(tryObject)
                    }
                }
                UndefinedTag_0xA432 = tempList
            }
            UndefinedTag_0xA433 = String.fromJson(tryDict.value(forKey: "UndefinedTag:0xA433"))
            UndefinedTag_0xA434 = String.fromJson(tryDict.value(forKey: "UndefinedTag:0xA434"))
        } else {
            return nil
        }
    }
}

class ExifInfoObject {

    var COMPUTED: COMPUTEDObject?
    var IFD0: IFD0Object?
    var EXIF: EXIFObject?

    init?(_ dict: NSDictionary?) {
        if let tryDict = dict {
            COMPUTED = COMPUTEDObject(tryDict.value(forKey: "COMPUTED") as? NSDictionary)
            IFD0 = IFD0Object(tryDict.value(forKey: "IFD0") as? NSDictionary)
            EXIF = EXIFObject(tryDict.value(forKey: "EXIF") as? NSDictionary)
        } else {
            return nil
        }
    }
}

class PhotoDetailObject {

    var pid: Int?               //图片 id
    var uid: Int?               //用户 id
    var wbpid: String?          //微博图片 id
    var scale: Double?          //图像比例 宽/高
    var origin: String?         //原始图片 id
    var text: String?           //图片简介文字
    var preset: String?         //滤镜名称
    var gps: String?            //GPS 地理信息
    var look: String?           //查看数 基本没用
    var like: String?           //喜欢数 基本没用
    var state: String?          //状态 基本没用
    var unix: Int64?            //新建时间
    var exif: ExifInfoObject?   //详细的 EXIF 信息 光圈 ISO 等信息都在这里
    var user: UserObject?       //用户信息

    init?(_ dict: NSDictionary?) {
        if let tryDict = dict {
            pid = Int.fromJson(tryDict.value(forKey: "pid"))
            uid = Int.fromJson(tryDict.value(forKey: "uid"))
            wbpid = String.fromJson(tryDict.value(forKey: "wbpid"))
            scale = Double.fromJson(tryDict.value(forKey: "scale"))
            origin = String.fromJson(tryDict.value(forKey: "origin"))
            text = String.fromJson(tryDict.value(forKey: "text"))
            preset = String.fromJson(tryDict.value(forKey: "preset"))
            gps = String.fromJson(tryDict.value(forKey: "gps"))
            look = String.fromJson(tryDict.value(forKey: "look"))
            like = String.fromJson(tryDict.value(forKey: "like"))
            state = String.fromJson(tryDict.value(forKey: "state"))
            unix = Int64.fromJson(tryDict.value(forKey: "unix"))
            exif = ExifInfoObject(tryDict.value(forKey: "exif") as? NSDictionary)
            user = UserObject(tryDict.value(forKey: "user") as? NSDictionary)
        } else {
            return nil
        }
    }
}

class PhotoUploadObject {

    var uid: String?    //用户id
    var scale: Double?  //比例
    var origin: String? //原始图片地址
    var unix: Int64?    //新建时间
    var exif: String?
    var pid: Int?       //图片 ID

    init?(_ dict: NSDictionary?) {
        if let tryDict = dict {
            uid = String.fromJson(tryDict.value(forKey: "uid"))
            scale = Double.fromJson(tryDict.value(forKey: "scale"))
            origin = String.fromJson(tryDict.value(forKey: "origin"))
            unix = Int64.fromJson(tryDict.value(forKey: "unix"))
            exif = String.fromJson(tryDict.value(forKey: "exif"))
            pid = Int.fromJson(tryDict.value(forKey: "pid"))
        } else {
            return nil
        }
    }
}

class UserInfoObject {

    var uid: Int?       //用户 id
    var name: String?   //用户名
    var avatar: Int?    //用户头像 id
    var des: String?    //简介
    var url: String?    //网站

    init?(_ dict: NSDictionary?) {
        if let tryDict = dict {
            uid = Int.fromJson(tryDict.value(forKey: "uid"))
            name = String.fromJson(tryDict.value(forKey: "name"))
            avatar = Int.fromJson(tryDict.value(forKey: "avatar"))
            des = String.fromJson(tryDict.value(forKey: "des"))
            url = String.fromJson(tryDict.value(forKey: "url"))
        } else {
            return nil
        }
    }
}
