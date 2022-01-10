## Havit-Practice-iOS
해빗 연습 갈겨 💜

### 1. RxSwift   
[RxSwift Repo 👀](https://github.com/Suyeon9911/RxSwift-Study)

### 2. URLSession + async/await

🙋🏻‍♂️ URLSession 을 알아야하는 이유
- swift에서 HTTP를 이용한 네트워크 사용 방법을 이해
- Alamofire, Moya 모두 URLSession을 wrapping한것뿐
- testable 코드를 만들 경우 URLSession을 알면 더욱 작성하기 용이
- Alamofire, Moya를 사용할 때 오류나 특정 log에 대한것을 이해하려면 URLSession을 알고 있어야 용이

❓ URLSession이란
- 앱과 서버간에 데이터를 주고받기 위해서 HTTP 사용
- URLSession은 URLSessionConfiguration을 통해 생성하고 URLSession은 여러 개의 URLSessionDataTask를 생성하여 이를 통해 서버와의 통신을 하고 Delegate를 통해 네트워크의 과정을 확인하는 형태

🌿 URLSessionConfiguration을 통해 URL 생성

- .default: 기본 통신을 할때 사용 (쿠키와 같은 저장 객체 사용)
- .ephemeral: 쿠키나 캐시를 저장하지 않는 정책을 사용할 때 이용
- .background: 앱이 백그라운드 상태에 있을 때 컨텐츠를 다운로드/업로드

🐥 URLSessionTask 작업 유형
- URLSessionDataTask: 기본적인 데이터를 받는 경우, response데이터를 메모리 상에서 처리
- URLSessionUploadTask: 파일 업로드 시 사용, 사용하기 편한 request body 제공
- URLSessionDownloadTask: 실제 파일을 다운받아 디스크에 사용될때 사용

### 3. CollectionView Cell
- LongPressGesture + 드래그앤드랍
- CollectionViewCell List 공부 




---

Coordinator   
IQKeyboardManager
