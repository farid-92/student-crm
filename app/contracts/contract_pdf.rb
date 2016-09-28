class ContractPdf < Prawn::Document

  def initialize(student, group)
    super()
    @student = student
    @group = group
    @course = @group.course
    @discipline_title = @group.course.discipline_title
    @practical_time = @course.practical_time.to_i
    @theoretical_time = @course.theoretical_time.to_i
    @educational_cost = @course.cost.to_i

    add_font
    header
    title
    subjects
    duties
    exams
    cost
    other
    validity
    dates
  end
  def add_font
    font_families.update("TimesNewRoman" => {
                             :normal => "app/assets/fonts/TimesNewRomanRegular.ttf",
                             :italic => "app/assets/fonts/TimesNewRomanItalic.ttf",
                             :bold => "app/assets/fonts/TimesNewRomanBold.ttf",
                             :bold_italic => "app/assets/fonts/TimesNewRomanBoldItalic.ttf"
                         })
    font "TimesNewRoman",
    :size => 11
  end

  def header
    text "ДОГОВОР",
         :align => :center, :style => :bold
    move_down 15
    text "на обучение компьютерным специальностям",
         :align => :center, :style => :bold
    define_grid(:columns => 6, :rows => 16, :gutter => 10)
    grid([1,0], [1,1]).bounding_box do
      text "г. Бишкек",
      :inline_format => true, :leading => 2
    end
    grid([1,0], [1,5]).bounding_box do
      text "#{Russian::strftime(Time.now, "%d %B %Y")}", :align => :right,
           :inline_format => true, :leading => 2
    end
  end

  def title
    text "<b>Общественный фонд «ИТ Аттрактор Плюс»</b>, в лице директора Гудова Александра Олеговича, действующего на основании Устава и Лицензии № 150002106 на образовательную деятельность, именуемый в дальнейшем <b>«Образовательный центр»</b>, с одной стороны, и гражданин(-ка)  <b>#{@student.full_name}</b>, именуемый(ая), в дальнейшем «<b>Студент</b>», с другой стороны, именуемые в дальнейшем <b>Стороны</b> (а по отдельности «<b>Сторона</b>») заключили настоящий <b>договор</b> (далее по тексту — «<b>договор</b>») -о нижеследующем: ",
         :inline_format => true, :leading => 2

  end

  def subjects
    move_down 30
    text "1. ПРЕДМЕТ ДОГОВОРА",
         :align => :center, :style => :bold
    move_down 15
    text "1.1. По настоящему договору <b>Образовательный центр</b> принимает на себя обязательства по обучению <b>Студента</b> в соответствии с учебной программой по дисциплине “#{@discipline_title}” (далее - «<b>Учебная программа</b>»), а <b>Студент</b> обязуется пройти курс обучения согласно <b>Учебной программе</b> и оплатить услуги <b>Образовательного центра</b>.
1.2.  По итогам обучения и успешно сданных итоговых экзаменов <b>Студенту</b> выдается Сертификат о прохождении курса “#{@discipline_title}”.",
         :inline_format => true, :leading => 2

  end

  def duties
    move_down 30
    text "2. ОБЯЗАННОСТИ СТОРОН",
         :align => :center, :style => :bold
    move_down 15
    text "2.1. <b>Образовательный центр</b> обязуется:
Провести обучение <b>Студента</b> в соответствии с внутренними правилами и требованиями <b>Образовательного центра</b>:
- провести в рамках <b>Учебной программы</b> практический курс обучения по очной форме обучения в объеме #{@practical_time} (#{I18n.with_locale(:ru) { @practical_time.to_words gender: :male }}) часов;
- провести в рамках <b>Учебной программы</b> теоретический курс обучения дистанционно в объеме #{@theoretical_time} (#{I18n.with_locale(:ru) { @theoretical_time.to_words gender: :male  }}) часов;
-  предоставить  <b>Студенту</b>  на  время  обучения  право  пользования  учебно-материальной  базой <b>Образовательного центра</b>;
2.2. <b>Студент</b> обязуется:
- изучить в полном объеме теоретический курс <b>Учебной программы</b>, отработать практический курс обучения, выполнить все домашние задания, предусмотренные <b>Учебной программой</b> курса, сдать все предусмотренные <b>Учебной программой</b> промежуточные контрольные, а также итоговый экзамен;
- предоставить в <b>Образовательный центр</b> копию удостоверения личности;
- не опаздывать и не пропускать занятия в <b>Образовательном центре</b> без уважительных причин;
- соблюдать внутренний распорядок, установленный в <b>Образовательном центре</b>;
- не появляться на занятиях в состоянии алкогольного опьянения, либо под воздействием психотропных или наркотических средств;
- бережно   относится   к   пособиям   и   оборудованию Образовательного центра. ",
         :inline_format => true, :leading => 2
  end

  def exams
    move_down 30
    text "3. УСЛОВИЯ ОБУЧЕНИЯ И СДАЧИ ЭКЗАМЕНОВ",
         :align => :center, :style => :bold
    move_down 15
    text "3.1. Срок проведения занятий по <b>Учебной программе</b> с #{Russian::strftime(@group.starts_at, "%d %B %Y")} по #{Russian::strftime(@group.ends_at, "%d %B %Y")}.
3.2. Теоретические и практические занятия <b>Студентов</b> проводятся в учебных группах не более 20 человек, согласно расписанию, утвержденному директором <b>Образовательного центра</b>.
3.3. К итоговому экзамену <b>Образовательного центра</b> допускается <b>Студент</b>, прошедший обучение в полном    объеме, успешно    сдавший    промежуточные контрольные    <b>Учебной    программы</b>, и полностью оплативший обучение.
3.4. <b>Студент</b>, допустивший пропуски занятий, к сдаче контрольных (экзамена) не допускается до момента отработки пропущенных занятий и сдачи всех домашних заданий.
3.5. <b>Студент</b>, явившийся на занятие в состоянии алкогольного опьянения либо под воздействием психотропных   или   наркотических   средств, от   дальнейшего   обучения   отстраняется   с последующим отчислением, без возврата оплаты за обучение;
3.6. В случае пропуска занятий в количестве 8 (восьми) и более занятий без уважительной причины, настоящий <b>договор</b> со <b>Студентом</b> расторгается, и <b>Студент</b> отчисляется с курсов без возврата оплаты за обучение.
3.7. В случае срыва занятия по вине <b>Студента</b> (неприбытие на занятие и  т.д.),  занятие  считается  проведенным.  Дополнительное занятие (за пропущенное) не проводится.
3.8. Преподавателям и администрации предоставляется право на отстранение от занятий <b>Студентов</b>, нарушающих внутренний распорядок <b>Образовательного центра</b>, дисциплину и технику безопасности.
3.9. Промежуточные контрольные и итоговый экзамен:
- проводятся в аудитории <b>Образовательного центра</b> 1 (один) раз в месяц и занимают по времени 8 (восемь) часов;
- для сдачи контрольной или экзамена, необходимо выполнить практическое задание, в присутствии преподавателя;
3.10. Студенту может быть предоставлена скидка на обучение, в случае сдачи промежуточной контрольной на “отлично”. Предоставление скидки происходит согласно правилам <b>Образовательного центра.</b>
3.11. В случае неудовлетворительных оценок на внутреннем экзамене сертификат <b>Образовательного центра Студенту</b> не выдается, при этом:
- Студенту разрешается сдать экзамен повторно, в составе учебной группы по назначенным <b>Образовательным центром</b> срокам, при условии получения допуска, после отработки дополнительных занятий по теории и практике в <b>Образовательном центре</b>;
-  повторные экзамены и дополнительные занятия оплачиваются <b>Заказчиком</b> согласно расценкам <b>Образовательного центра</b>;",

         :inline_format => true, :leading => 2

  end

  def cost
    move_down 30
    text "4. СТОИМОСТЬ ОБУЧЕНИЯ И ПОРЯДОК ОПЛАТЫ",
         :align => :center, :style => :bold
    move_down 15
    text "4.1. Стоимость обучения составляет #{@educational_cost} (#{I18n.with_locale(:ru) { @educational_cost.to_words gender: :male  }}) сомов без учета скидок на обучение.
4.2. Оплата обучения производится наличным расчетом в кассу <b>Образовательного центра</b> или безналичным расчетом путем перечисления денежных средств на р/счет <b>Образовательного центра</b>.
4.3. При расторжении <b>Договора</b> по инициативе <b>Студента</b>, а также при отчислении <b>Студента Образовательным центром</b> стоимость проведенных занятий не возвращается (п.3.6).",
         :inline_format => true, :leading => 2

  end


  def other
    move_down 30
    text "5. ДОПОЛНИТЕЛЬНЫЕ УСЛОВИЯ",
         :align => :center, :style => :bold
    move_down 15
    text "5.1. Стороны освобождаются от ответственности за частичное или полное неисполнение обязательств по настоящему Договору, если оно явилось следствием обстоятельств непреодолимой силы, например: пожара, наводнения, землетрясения, войны, военных действий любого характера, блокады, эмбарго на экспорт или импорт. При этом срок выполнения обязательств по Договору отодвигается соразмерно времени, в течение которого действовали такие обстоятельства и их последствия.",
         :inline_format => true, :leading => 2
  end
  def validity
    move_down 30
    text "6. СРОК ДЕЙСТВИЯ, ПОРЯДОК ИЗМЕНЕНИЯ И РАСТОРЖЕНИЯ ДОГОВОРА",
         :align => :center, :style => :bold
    move_down 15
    text "6.1. <b>Договор</b> вступает в силу с момента подписания его <b>Сторонами</b> и действует до окончания обучения  <b>Студентов</b> в соответствии с расписанием <b>Образовательного центра</b>.
6.2. <b>Договор</b> может быть расторгнут до окончания срока действия по соглашению <b>Сторон</b>, а также в случае невыполнения или ненадлежащего выполнения <b>Сторонами</b> обязательств по настоящему договору.
6.3.  Условия <b>Договора</b> могут быть изменены и дополнены по взаимному согласию <b>Сторон</b> с обязательным составлением дополнительного соглашения к настоящему договору.
6.4. Настоящий <b>договор</b> подписан в двух экземплярах: по одному для каждой из сторон, оба экземпляра имеют равную правовую силу.",
         :inline_format => true, :leading => 2
  end
  def dates
    move_down 30
    text "7. РЕКВИЗИТЫ и ПОДПИСИ СТОРОН",
         :align => :center, :style => :bold

    define_grid(:columns => 6, :rows => 13, :gutter => 10)
    grid([2,0], [10,2]).bounding_box do
    text "<b>Образовательный центр</b>
Общественный фонд “ИТ Аттрактор Плюс”
г. Бишкек, ул.Малдыбаева 7/1,
УГНС по Октябрьскому району
ИНН 01206201510105
ОКПО 29075355
ФЗАО “БТА Банк” г.Бишкек
р/с 1190061000098710
БИК 119006
Email: it.attractor.plus@gmail.com,
Web: http://it-attractor-plus.com/
Тел.: 0(707)86-12-77




Директор
Гудов А.О.",
         :inline_format => true, :leading => 2
    end

    grid([2,3], [7,5]).bounding_box do
      text "<b>Заказчик</b>
#{@student.name} #{@student.surname}
#{@student.passport_id}
Выдан #{@student.issue_date.strftime("%d-%m-%Y")}
#{@student.issued_by}
Тел: #{@student.first_phone}
Email: #{@student.email}
Skype: #{@student.skype}








Заказчик
#{@student.name} #{@student.surname}
",
           :inline_format => true, :leading => 2
    end

  end

end