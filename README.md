# LingoChat Helm Chart

RingoChat Helm Chart는 AI 기반 채팅 서비스인 RingoChat을 Kubernetes 환경에서 손쉽게 배포할 수 있도록 구성된 Helm Chart 입니다.

해당 차트는 다음과 같은 주요 구성 요소를 포함합니다.

- lingo-nginx: 프론트엔드 정적 파일을 제공하고 리버스 프록시 역할 수행
- lingo-socket: WebSocket 연결을 관리하는 실시간 통신 서버
- lingo-api: NestJS 기반 백엔드 API 서버

## 사전 요구 사항

RingoChat Helm Chart를 설치하기 전에 필요한 환경입니다.

- Kubernetes Cluster (v1.22 이상 권장)
- [Helm v3](https://helm.sh/docs/intro/install/)
- 외부 접근이 필요한 경우 Nginx Ingress Controller 설치 및 설정
- Secret 참조를 위한 Vault 설치 및 설정

## 설치 방법

#### 헬름 차트 저장소 추가

```
git clone https://github.com/haeseung123/lingo-chat-helm.git
```

#### 커스텀 설정 적용 후 설치

values.yaml 파일을 수정하여 원하는 설정을 적용한 후 설치합니다.

```
helm install lingo lingo-chat-helm/.
```

## 구성 요소 설명

### lingo-nginx

- 프론트엔드 정적 파일 제공
- 리버스 프록시 역할 수행
- https://github.com/lingo-chat/lingo-chat

### lingo-api

- WebSocket 연결 및 메시지 처리
- 실시간 채팅 기능 관리
- https://github.com/haeseung123/lingo-chat-socket-server

### lingo-api

- NestJS 기반 API 서버
- 사용자 인증, CRUD 등 제공
- https://github.com/lingo-chat/lingo-chat-api-server

## Configuration

### values.yaml

이 Helm Chart는 values.yaml을 통해 다양한 설정이 가능합니다.

예시:

```
socket:
  config:
    SERVER_PORT: ""
    REDIS_HOST: ""
    REDIS_PORT: ""
    REDIS_DB: ""
    API_SERVER_URL: ""
```

⚠️ 보안상의 이유로 ConfigMap이나 Secret으로 관리되는 환경 변수는 직접 포함하지 않습니다.

### ingress를 사용한 도메인 설정

values.yaml을 수정합니다:

```
ingress:
  enabled: false -> true
  host: ""
```

enabled를 true로 변경하고 host를 설정합니다. 이후 네임서버의 레코드값을 알맞게 설정해주어야합니다.

### Vault Secret 관리

API 서버 실행시 주입될 아래의 Key/Vaule 값을 설정해야합니다.

예시:

```
POSTGRESQL_USER=
POSTGRESQL_PASSWORD=
OAUTH_GOOGLE_CLIENT_ID=
OAUTH_GOOGLE_SECRET=
JWT_ACCESS_SECRET_KEY=
JWT_REFRESH_SECRET_KEY=
```

## 업그레이드 및 제거

#### 새 버전으로 업그레이드

```
helm upgrade lingo lingo-chat-helm/.
```

#### 제거

```
helm unintsall lingo
```
