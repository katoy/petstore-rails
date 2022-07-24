# openapi に沿って petstore を開発
## 概要

### 起動

```sh
docker-composer build
dockercpmpose up -d
```

- <http://localhost:3000/pets>, http://loalhost:3000/pets/1,  http://localhost:3000/users などに web ブラウザでアクセうしてください。
json が返ってくるのがわかるます。


- src 以下の yaml を編集したら dest/merge.yaml も更新されます。

- 手動で openapi 書類の merge, tml, pdf ファイルの生成するには ./merge.sh を実行します。

./dest/* 以下をクリアするには ./clean-merged.sh を実行します。
### rspec

```sh
docker-compose run --rm web bundle exec rspec
```

で rspec を実行できます。
この rspec は dest/openapi/openapi.yaml に提示した API 仕様のと 実際のレウsポンス形式が一致しているかのチェックも行っています。


## 参考

- <https://speakerdeck.com/cafedomancer/openapi-what-is-that-is-that-tasty>
  OpenAPI？ なにそれ？ おいしいの？

- https://zenn.dev/leaner_tech/articles/20210813-openapi-additional-properties
> 例えば他ユーザの本名や IP アドレスが意図せず API レスポンスに含まれてしまうと大問題になりえます。
こうした挙動を防ぐには、レスポンス定義に additionalProperties: false を指定します。

- <https://github.com/cafedomancer/petstore>
  fork 元
