# demo-app-gitaction-argocd

### Architecture

![Untitled](https://user-images.githubusercontent.com/77256060/166134200-6a4787c9-0719-49ad-a2cb-a11d7a6a3f3e.png)

### ECR 로그인을 위한 Secret 생성

kubectl create secret docker-registry ecr-cred \
--docker-server=${aws_account_id}.dkr.ecr.ap-northeast-2.amazonaws.com \
--docker-username=AWS \
--docker-password=$(aws ecr get-login-password --region ap-northeast-2) \
--namespace=default

### Work Flow

1. 개발자가 수정된 앱 git push **(APP REPOSITORY)**
2. Github Action (CI)
    1. Configure AWS credentials (Github Secret에 미리 등록 된 AWS KEY 사용)
    2. ECR Login
    3. Set Value : ECR_REGISTRY, ECR_REPOSITORY, IMAGE_TAG(cat VERSION file)
    4. docker image build & push
    
![Untitled 1](https://user-images.githubusercontent.com/77256060/166134228-e69d6e9d-252b-4167-a176-f9a34ad7e74a.png)
    
3. Github Action (CD)
    1. **CONFIG REPOSITORY** git clone
    2. config repository의 helm - values.yaml 수정
    3. image tag를 수정하여 이미지 버전 업데이트
    4. 수정된 values.yaml 다시 push (GH_TOKEN Secret 등록 필요)
    
![Untitled 2](https://user-images.githubusercontent.com/77256060/166134237-d94cb006-9c6b-4276-ba7b-b9a1e0da17ad.png)

    
4. ArgoCD에서 3분에 한번씩 config-repository Check하여 업데이트 수행
5. Github Web hook을 통해 ArgoCD로 push 할 수도 있음

![Untitled 3](https://user-images.githubusercontent.com/77256060/166134243-d8b0e291-123e-4045-adba-442372aa574a.png)

**config-repo(Helm) : ‣**

**app-repo : https://github.com/DACHANCHOI/demo-app-gitaction-argocd**

***config-repo(helm) 와 app-repo를 구분 하는 이유는 모든 서비스 app-repo에서 helm config를 가지고 있으면 repo 관리 차원에서 더 관리 어려워질 수 있음. config-repo를 표준화 하여 관리 하는 것이 더 좋음**
