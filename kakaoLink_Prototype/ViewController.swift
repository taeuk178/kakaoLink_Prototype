//
//  ViewController.swift
//  kakaoLink_Prototype
//
//  Created by tw on 2022/05/14.
//

import UIKit
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKLink
import KakaoSDKTemplate
import KakaoSDKTalk


class ViewController: UIViewController {

    let feedTemplateJsonStringData =
        """
        {
            "object_type": "feed",
            "content": {
                "title": "테스트",
                "description": "https://open.kakao.com/o/g4DHB1vd",
                "image_url": "https://mud-kage.kakao.com/dn/Q2iNx/btqgeRgV54P/VLdBs9cvyn8BJXB3o7N8UK/kakaolink40_original.png",
                "link": {
                    "mobile_web_url": "https://open.kakao.com/o/g4DHB1vd",
                    "web_url": "https://open.kakao.com/o/g4DHB1vd"
                }
            },
            "buttons": [
                {
                    "title": "웹으로 보기",
                    "link": {
                        "mobile_web_url": "https://open.kakao.com/o/g4DHB1vd",
                        "web_url": "https://open.kakao.com/o/g4DHB1vd"
                    }
                },
                {
                    "title": "앱으로 보기",
                    "link": {
                        "android_execution_params": "key1=value1&key2=value2",
                        "ios_execution_params": "key1=value1&key2=value2"
                    }
                }
            ]
        }
        """.data(using: .utf8)!
    
    @IBOutlet weak var kakaoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if LinkApi.isKakaoLinkAvailable() {
//            // 카카오톡으로 카카오링크 공유 가능
//            LinkApi.shared.customLink(templateId: templateId, templateArgs:["title":"제목이다.", "description":"설명입니다."]) {(linkResult, error) in
//                if let error = error {
//                    print(error)
//                }
//                else {
//                    print("customLink() success.")
//                    if let linkResult = linkResult {
//                        UIApplication.shared.open(linkResult.url, options: [:], completionHandler: nil)
//                    }
//                }
//            }
//        }
//        LinkApi.shared.scrapLink(requestUrl: requestUrl, templateId: templateId) {(linkResult, error) in
//            if let error = error {
//                print(error)
//            }
//            else {
//                print("scrapLink() success.")
//                if let linkResult = linkResult {
//                    UIApplication.shared.open(linkResult.url, options: [:], completionHandler: nil)
//                }
//            }
//        }
            
//        LinkApi.shared.customLink(templateId: templateId) { (linkResult, error) in
//            if let error = error {
//                print(error)
//            }
//            else {
//                print("customLink() success.")
//                if let linkResult = linkResult {
//                    // 카카오톡 오픈
//                    UIApplication.shared.open(linkResult.url, options: [:], completionHandler: nil)
//                }
//            }
//        }
    

    }


    @IBAction func kakaoLogin(_ sender: UIButton) {
        // 카카오톡 설치 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")

                    //do something
                    _ = oauthToken
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                    if let error = error {
                        print(error)
                    }
                    else {
                        print("loginWithKakaoAccount() success.")

                        //do something
                        _ = oauthToken
                    }
                }
        }
    }
    
    @IBAction func sendMessages(_ sender: UIButton) {
        let templateId: Int64 = 76584

        // templatable은 메시지 만들기 항목 참고
        if let templatable = try? SdkJSONDecoder.custom.decode(FeedTemplate.self, from: feedTemplateJsonStringData) {
            TalkApi.shared.sendDefaultMemo(templatable: templatable) {(error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("success.")
                }
            }
        }
//        TalkApi.shared.sendCustomMemo(templateId: templateId, templateArgs: ["msg":"메세지 파라미터"]) {(error) in
//            if let error = error {
//                print(error)
//            }
//            else {
//                print("success.")
//            }
//        }
    }
}

