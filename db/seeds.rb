Speaker.create!(
  first_name: 'テスト',
  last_name: 'スピーカー',
  company: '株式会社△△△△',
  profile: '2010年に株式会社△△△△に入社。サーバサイドのパフォーマンス改善などの経験を積み、現在はリードエンジニアとして開発全般の技術責任者を務める。'
)

Speaker.first.events.create!(
  title: '【オンライン】Ruby on Rails パフォーマンス・チューニングについて',
  thema: '速度計測の方法から実践すべきTipまでご紹介します！',
  content: 'Webページの表示速度は、利用者に快適なサービスを提供するためにとても大切です。\n
  しかしながら、利用者やデータの増加、機能の高度化などにより、様々な要因でサービスのパフォーマンスは日々劣化していきます。\n
  本セミナーでは、ツールを使ったパフォーマンス計測の方法や、高速化するために行っている工夫、利用しているライブラリなど、社内で行っている取り組みについてご紹介します。',
  start_at: Time.zone.now + 1.months,
  end_at: Time.zone.now + 1.months + 2.hours
)

29.times do |n|
  company = Faker::Company.name
  Speaker.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    company:  company,
    profile: "2010年に#{company}に入社。"
  )
end

Speaker.all.each.with_index(2) do |speaker, i|
  speaker.events.create!(
    title: "example-タイトル-#{i}",
    thema: "example-テーマ-#{i}",
    content: "example-内容-#{i}",
    start_at: Time.zone.now + 1.months,
    end_at: Time.zone.now + 1.months + 2.hours
  )
end
