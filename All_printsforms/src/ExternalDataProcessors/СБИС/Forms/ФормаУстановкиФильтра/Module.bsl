
&НаКлиенте
Процедура ПриОткрытии(Отказ)
	Если ЭтаФорма.ВладелецФормы.ФильтрПериод = Неопределено Тогда
		ФильтрПериод = Элементы.ФильтрПериод.СписокВыбора.НайтиПоИдентификатору(0).Значение;
	Иначе
		ФильтрПериод = ЭтаФорма.ВладелецФормы.ФильтрПериод;
	КонецЕсли;
	//ФильтрДатаНач = ЭтаФорма.ВладелецФормы.ФильтрДатаНач;
	//ФильтрДатаКнц = ЭтаФорма.ВладелецФормы.ФильтрДатаКнц;
	//ФильтрСостояние = ЭтаФорма.ВладелецФормы.ФильтрСостояние;
	//ФильтрТипыДокументов = ЭтаФорма.ВладелецФормы.ФильтрТипыДокументов;
	//ФильтрКонтрагент = ЭтаФорма.ВладелецФормы.ФильтрКонтрагент;
	//ФильтрКонтрагентПодключен = ЭтаФорма.ВладелецФормы.ФильтрКонтрагентПодключен;
	//ФильтрОрганизация = ЭтаФорма.ВладелецФормы.ФильтрОрганизация;
	//ФильтрОтветственный = ЭтаФорма.ВладелецФормы.ФильтрОтветственный;
	//ФильтрМаска = ЭтаФорма.ВладелецФормы.ФильтрМаска;
	//
	ЗаполнитьЗначенияСвойств(ЭтаФорма, ВладелецФормы, 
		"ФильтрДатаНач,ФильтрДатаКнц,ФильтрСостояние,ФильтрТипыДокументов,ФильтрКонтрагент,"+
		"ФильтрКонтрагентПодключен,ФильтрКонтрагентСФилиалами,ФильтрОрганизация,ФильтрОтветственный,ФильтрМаска");
	Элементы.ФильтрСостояние.СписокВыбора.ЗагрузитьЗначения(ЭтаФорма.ВладелецФормы.СписокСостояний.ВыгрузитьЗначения());
	Если Элементы.ФильтрТипыДокументов.СписокВыбора.НайтиПоЗначению("ЭДОНакл") = Неопределено Тогда
		Элементы.ФильтрТипыДокументов.СписокВыбора.Добавить("ЭДОНакл", "Накладные");
	    Элементы.ФильтрТипыДокументов.СписокВыбора.Добавить("АктВР", "Акты (услуги, работы, права)");
	    Элементы.ФильтрТипыДокументов.СписокВыбора.Добавить("СчФктр,УпдСчфДоп",	"Счета-фактуры (вкл.в составе УПД)");
	    Элементы.ФильтрТипыДокументов.СписокВыбора.Добавить("УпдДоп", "Передаточные документы");
	    Элементы.ФильтрТипыДокументов.СписокВыбора.Добавить("счФактКор,УкдКсчфДис", "Счета-фактуры корректировочные (вкл. в составе УКД)");
		Элементы.ФильтрТипыДокументов.СписокВыбора.Добавить("УкдДис", "УКД");
	    Элементы.ФильтрТипыДокументов.СписокВыбора.Добавить("АктСвер", "Акты сверки");
	    Элементы.ФильтрТипыДокументов.СписокВыбора.Добавить("Договор", "Договоры");
	    Элементы.ФильтрТипыДокументов.СписокВыбора.Добавить("ЭДОСч", "Счета");
		Элементы.ФильтрТипыДокументов.СписокВыбора.Добавить("АктПриемки", "Акты о приемке");
		Элементы.ФильтрТипыДокументов.СписокВыбора.Добавить("Заказ", "Заказы поставщикам");
		Элементы.ФильтрТипыДокументов.СписокВыбора.СортироватьПоПредставлению();
	КонецЕсли;
	
	ФильтрУстановитьВидимость(ФильтрПериод);
КонецПроцедуры

&НаКлиенте
Процедура Отобрать(Команда)
	ЭтаФорма.ВладелецФормы.ФильтрПериод = ФильтрПериод;
	ЭтаФорма.ВладелецФормы.ФильтрДатаНач = ФильтрДатаНач;
	ЭтаФорма.ВладелецФормы.ФильтрДатаКнц = ФильтрДатаКнц;
	ЭтаФорма.ВладелецФормы.ФильтрСостояние = ФильтрСостояние;
	ЭтаФорма.ВладелецФормы.ФильтрТипыДокументов = ФильтрТипыДокументов;
	ЭтаФорма.ВладелецФормы.ФильтрКонтрагент = ФильтрКонтрагент;
	ЭтаФорма.ВладелецФормы.ФильтрКонтрагентПодключен = ФильтрКонтрагентПодключен;
	ЭтаФорма.ВладелецФормы.ФильтрКонтрагентСФилиалами = ФильтрКонтрагентСФилиалами;
	ЭтаФорма.ВладелецФормы.ФильтрОрганизация = ФильтрОрганизация;	
	ЭтаФорма.ВладелецФормы.ФильтрОтветственный = ФильтрОтветственный;
	ЭтаФорма.ВладелецФормы.ФильтрМаска = ФильтрМаска;
	ЭтаФорма.ВладелецФормы.ФильтрСтраница = 1;
	
	ЭтаФорма.Закрыть(Истина);
КонецПроцедуры

&НаКлиенте
Процедура ФильтрУстановитьВидимость(Период)
	Если(Период="За период") Тогда
		Элементы.ФильтрДатаНач.Видимость = Истина;
		Элементы.ФильтрДатаКнц.Видимость = Истина;
	иначе
		Элементы.ФильтрДатаНач.Видимость = Ложь;
		Элементы.ФильтрДатаКнц.Видимость = Ложь;
	КонецЕсли;
	МестныйКэш = ЭтаФорма.ВладелецФормы.Кэш;
	ТекущийРаздел = МестныйКэш.Разделы["р"+МестныйКэш.Текущий.Раздел];
	фрм = ЭтаФорма.ВладелецФормы.сбисНайтиФормуФункции("ФильтрУстановитьВидимость","Раздел_"+ТекущийРаздел+"_"+МестныйКэш.Текущий.ТипДок,"Раздел_"+ТекущийРаздел+"_Шаблон",МестныйКэш);	
	фрм.ФильтрУстановитьВидимость(ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура ФильтрПериодПриИзменении(Элемент)
	ФильтрУстановитьВидимость(ФильтрПериод);
	Если(ФильтрПериод="За весь период") Тогда
		ФильтрДатаНач="";
		ФильтрДатаКнц="";
		Возврат;
	КонецЕсли;
	Если(ФильтрПериод="За сегодня") Тогда
		ФильтрДатаНач = ТекущаяДата();
		ФильтрДатаКнц = ТекущаяДата();
		Возврат;
	КонецЕсли;
	Если(ФильтрПериод = "За последний месяц") Тогда
		ФильтрДатаКнц = ТекущаяДата();
		ФильтрДатаНач = ДобавитьМесяц(ФильтрДатаКнц,-1);
		Возврат;
	КонецЕсли;
	Если(ФильтрПериод = "За последние полгода") Тогда
		ФильтрДатаКнц = ТекущаяДата();
		ФильтрДатаНач = ДобавитьМесяц(ФильтрДатаКнц,-6);
		Возврат;
	КонецЕсли;
	Если(ФильтрПериод = "За последний год") Тогда
		ФильтрДатаКнц = ТекущаяДата();
		ФильтрДатаНач = ДобавитьМесяц(ФильтрДатаКнц,-12);
		Возврат;
	КонецЕсли;
КонецПроцедуры
&НаКлиенте
Процедура ФильтрОчистить(Элемент)
	ФильтрПериод = "За весь период";
	ФильтрДатаНач = "";
	ФильтрДатаКнц = "";
	ФильтрСостояние = ЭтаФорма.ВладелецФормы.СписокСостояний.НайтиПоИдентификатору(0).Значение;
	ФильтрКонтрагент = ЭтаФорма.Элементы.ФильтрКонтрагент.ОграничениеТипа.ПривестиЗначение();
	ФильтрКонтрагентПодключен = "";
	ФильтрКонтрагентСФилиалами = Ложь;
	ФильтрОрганизация = ЭтаФорма.Элементы.ФильтрОрганизация.ОграничениеТипа.ПривестиЗначение();
	ФильтрМаска = "";
	ФильтрТипыДокументов = Новый СписокЗначений();
	ФильтрОтветственный = ЭтаФорма.Элементы.ФильтрОтветственный.ОграничениеТипа.ПривестиЗначение();
КонецПроцедуры
&НаКлиенте
Процедура ПослеОтметкиТиповДокументов(Список, Параметры) Экспорт
	Если Список <> Неопределено Тогда
		ФильтрТипыДокументов.Очистить();
		Для Каждого элементВыбора из Список цикл
		    Если элементВыбора.Пометка Тогда
				ФильтрТипыДокументов.Добавить(элементВыбора.значение, элементВыбора.представление);
		    КонецЕсли;
		КонецЦикла;
    КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ФильтрТипыДокументовНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	СтандартнаяОбработка=ложь;
	Для Каждого элементВыбора из Элемент.СписокВыбора цикл		
		Если ФильтрТипыДокументов.НайтиПоЗначению(элементВыбора.значение) <>неопределено Тогда
			элементВыбора.Пометка=истина;
		КонецЕсли;
	КонецЦикла;
	Оповещение = Новый ОписаниеОповещения("ПослеОтметкиТиповДокументов", ЭтаФорма);
	Элемент.СписокВыбора.ПоказатьОтметкуЭлементов(Оповещение, "Выберите типы");
КонецПроцедуры


