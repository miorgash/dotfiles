# Design

- analysis 内
  - adhoc は環境（container）に一つ以上の report が紐付くため，ディレクトリを分ける．
  - それ以外は一つの環境がただ一つの目的のために用意されるため，Dockerfile などの IaC は目的それぞれのプロジェクトに内包させる


mkdirs で作成する構造
- data : ?
- analysis (for knowledge) : 内包物の「フォーマルさ」で以下ディレクトリを使い分ける
  - adhoc : 場当たり的に作成されるレポートと，その分析のための環境．開発にあたっては，様式に囚われずスピードを重んじる．
    - containers
    - reports
  - scripts : 繰り返される手順のうち，処理の流れが簡略で実行の目的が一般的なもの．開発にあたっては，展開の容易さを何よりも重んじインターフェースを工夫する．又，メンテナンスが出来る限り容易になるよう設計を工夫する．
  - pipelines : 繰り返される手順のうち，処理の流れが長大で実行の目的が特殊なもの．開発にあたっては，メンテナンスの容易さを何よりも重んじ設計を工夫する．又，展開ができる限り容易になるようインターフェースを工夫する．
  - pkg : tools for my own # coming soon
  - app : tools for teams # coming soon
- training (for more efficient analysis)
  - algorithms (coming soon)
  - libraries (coming soon)
  - teaching (for getting job by PR on WEB platforms, or for learning by teaching)
