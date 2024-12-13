
#Область include_core_vo2_Раздел_Полученные_Шаблон

&НаКлиенте
Перем МестныйКэш;

// функции для совместимости кода 
&НаКлиенте
Функция сбисЭлементФормы(Форма,ИмяЭлемента)
	Если ТипЗнч(ЭтаФорма) = Тип("УправляемаяФорма") Тогда
		Возврат Форма.Элементы.Найти(ИмяЭлемента);
	КонецЕсли;
	Возврат Форма.ЭлементыФормы.Найти(ИмяЭлемента);
КонецФункции

&НаКлиенте
Функция сбисПолучитьСтраницу(Элемент, ИмяСтраницы)
	Если ТипЗнч(ЭтаФорма) = Тип("УправляемаяФорма") Тогда
		Возврат Элемент.ПодчиненныеЭлементы[ИмяСтраницы];
	КонецЕсли;
	Возврат Элемент.Страницы[ИмяСтраницы];
КонецФункции

// функция обновляет контент для подразделов раздела Полученные	
&НаКлиенте
Функция ОбновитьКонтент(Кэш) Экспорт
	МестныйКэш = Кэш;
	СтруктураДляОбновленияФормы = Кэш.Интеграция.сбисПолучитьСписокДокументов(Кэш);
	Кэш.ОбщиеФункции.ОбновитьПанельНавигации(Кэш);
	ГлавноеОкно = Кэш.ГлавноеОкно;
	Контент = сбисЭлементФормы(ГлавноеОкно, "Контент");
	Контент.ТекущаяСтраница = сбисПолучитьСтраницу(Контент, "РеестрДокументов");	
	Кэш.ТаблДок = сбисЭлементФормы(ГлавноеОкно,"Таблица_РеестрДокументов");
	Кэш.ГлавноеОкно.СписокДопОперацийРеестра.Очистить();
	Возврат СтруктураДляОбновленияФормы;
КонецФункции

// Процедура открывает окно просмотра документа	
&НаКлиенте
Процедура ПоказатьДокумент(Кэш, СтрТабл) Экспорт
	МестныйКэш = Кэш;
	ГлавноеОкно = Кэш.ГлавноеОкно;
	МассивПакетов = ПодготовитьСтруктуруДокумента(СтрТабл, Кэш);
	Если МассивПакетов.Количество() > 0 Тогда
		ПолныйСоставПакета = МассивПакетов[0];
		сч = 0;
		Для Каждого Элемент Из ПолныйСоставПакета.Вложение Цикл
			Если ПолныйСоставПакета.Свойство("Событие") Тогда
				Элемент.Вставить("Событие", ПолныйСоставПакета.Событие);
			КонецЕсли;
			ТекстHTML = Кэш.Интеграция.ПолучитьHTMLВложения(Кэш, ПолныйСоставПакета.Идентификатор, Элемент);
			ПолныйСоставПакета.Вложение[сч].Вставить("ТекстHTML",ТекстHTML);
			ПолныйСоставПакета.Вложение[сч].Вставить("Отмечен",Истина);
			сч = сч+1;
		КонецЦикла;
		фрм = ГлавноеОкно.сбисНайтиФормуФункции("ПоказатьДокумент","ФормаПросмотрДокумента","", Кэш);
		фрм.ПоказатьДокумент(Кэш,ПолныйСоставПакета);	
	КонецЕсли;
КонецПроцедуры

// Процедура обновляет панель массовых операций, панель фильтра, контекстное меню при смене раздела	
&НаКлиенте
Процедура НаСменуРаздела(Кэш) Экспорт
	фрм = Кэш.ГлавноеОкно.сбисНайтиФормуФункции("НаСменуРаздела","Раздел_Полученные_Полученные","", Кэш);
	фрм.НаСменуРаздела(Кэш);
КонецПроцедуры

// Процедура устанавливает панель навигации на 1ую страницу
//
// Параметры:
//  Кэш		- Структура		- кэш обработки
//
&НаКлиенте
Процедура НавигацияУстановитьПанель(Кэш) Экспорт
	Кэш.ГлавноеОкно.СбисЭлементФормы(Кэш.ГлавноеОкно,		"ПанельНавигации"		).Видимость = Истина;
	Кэш.ГлавноеОкно.СбисЭлементФормы(Кэш.ГлавноеОкно,		"ЗаписейНаСтранице1С"	).Видимость = Ложь;
	Кэш.ГлавноеОкно.СбисЭлементФормы(Кэш.ГлавноеОкно,		"ЗаписейНаСтранице"		).Видимость = Истина;
КонецПроцедуры

// функция формирует структуру данных по пакету электронных документов, необходимую для его предварительного просмотра и загрузки в 1С		
&НаКлиенте
Функция ПодготовитьСтруктуруДокумента(СтрокаСпискаДокументов, Кэш) Экспорт
	Возврат Кэш.ОбщиеФункции.ПодготовитьСтруктуруДокументаСбис(СтрокаСпискаДокументов, Кэш);	
КонецФункции

// Процедура устанавливает значения фильтра по-умолчанию для текущего раздела	
&НаКлиенте
Процедура ФильтрОчистить(Кэш) Экспорт
	ГлавноеОкно = Кэш.ГлавноеОкно;
	Если ТипЗнч(ЭтаФорма) = Тип("УправляемаяФорма") Тогда
		ГлавноеОкно.ФильтрПериод = "За весь период";
	Иначе
		ГлавноеОкно.ФильтрПериод = "0";
	КонецЕсли;
	Если Кэш.ТипыПолейФильтра.Свойство("ФильтрОрганизация") Тогда
		ГлавноеОкно.ФильтрОрганизация = Кэш.ТипыПолейФильтра.ФильтрОрганизация.ПривестиЗначение();
	Иначе	
		ГлавноеОкно.ФильтрОрганизация = "";
	КонецЕсли;
	Если Кэш.ТипыПолейФильтра.Свойство("ФильтрКонтрагент") Тогда
		ГлавноеОкно.ФильтрКонтрагент = Кэш.ТипыПолейФильтра.ФильтрКонтрагент.ПривестиЗначение();
	Иначе	
		ГлавноеОкно.ФильтрКонтрагент = "";
	КонецЕсли;
	Если Кэш.ТипыПолейФильтра.Свойство("ФильтрОтветственный") Тогда
		ГлавноеОкно.ФильтрОтветственный = Кэш.ТипыПолейФильтра.ФильтрОтветственный.ПривестиЗначение();
	Иначе	
		ГлавноеОкно.ФильтрОтветственный = "";
	КонецЕсли;
	ГлавноеОкно.ФильтрДатаНач = "";
	ГлавноеОкно.ФильтрДатаКнц = "";
	ГлавноеОкно.ФильтрСостояние = ГлавноеОкно.СписокСостояний.НайтиПоИдентификатору(0).Значение;
	ГлавноеОкно.ФильтрКонтрагентПодключен = "";
	ГлавноеОкно.ФильтрКонтрагентСФилиалами = Ложь;
	ГлавноеОкно.ФильтрСтраница = 1;
	ГлавноеОкно.ФильтрМаска = "";
КонецПроцедуры

&НаКлиенте
Функция сбисСписокДополнительныхОпераций(Кэш, ФормаПросмотра) Экспорт
	СписокДопОпераций = Новый СписокЗначений;
	СписокДопОпераций.Добавить("СбисПечать", "Печать");
	СписокДопОпераций.Добавить("СохранитьНаДиск", "Сохранить на диск");
	СписокДопОпераций.Добавить("ОткрытьДокументОнлайн", "Открыть документ на sbis.ru");
	СписокДопОпераций.Добавить("ОткрытьКонтрагентаОнлайнПоПакету", "Открыть контрагента на sbis.ru");
	СписокДопОпераций.Добавить("СформироватьРасхождение", "Сформировать расхождение");
	ФормаПросмотра.СервисДопОперацияПросмотра(СписокДопОпераций);	// alo доп операции из инишки Сервис
	Возврат СписокДопОпераций;
КонецФункции

&НаКлиенте
Функция СохранитьНаДиск(Кэш, ФормаПросмотра) Экспорт
	ФормаПросмотра.СохранитьНаДискНажатие("");
КонецФункции

&НаКлиенте
Функция СбисПечать(Кэш, ФормаПросмотра) Экспорт
	ФормаПросмотра.СбисПечать("");
КонецФункции

&НаКлиенте
Функция ОткрытьДокументОнлайн(Кэш, ФормаПросмотра) Экспорт
	Если ФормаПросмотра<>Неопределено Тогда
	ФормаПросмотра.ОткрытьДокументОнлайн("");
	КонецЕсли;
КонецФункции

&НаКлиенте
Функция СформироватьРасхождение(Кэш, ФормаПросмотра) Экспорт
	ФормаПросмотра.СформироватьРасхождениеНажатие("");
КонецФункции

&НаКлиенте
функция сбисПовторитьЭтап(Кэш, ФормаПросмотра, НазваниеЭтапа) экспорт
	Отказ = Ложь;
	СоставПакета = Кэш.Интеграция.сбисПовторитьЭтап(Кэш, ФормаПросмотра.СоставПакета.Идентификатор, НазваниеЭтапа,Отказ);
	Если Не Отказ Тогда
		ФормаПросмотра.СоставПакета.Вставить("Этап", СоставПакета.Этап);
		УстановитьВидимостьЭлементовВформеПросмотра(ФормаПросмотра, ФормаПросмотра.СоставПакета, Кэш.Парам);
	КонецЕсли;
КонецФункции

// Функция заполняет данные о прохождении документа	
&НаКлиенте
Функция ЗаполнитьПрохождение(СоставПакета) Экспорт
	Если	МестныйКэш = Неопределено 
		И 	НЕ ЭтаФорма.ВладелецФормы = Неопределено Тогда
		
		Попытка
			МестныйКэш = ЭтаФорма.ВладелецФормы.Кэш;
		Исключение
			МестныйКэш = ЭтаФорма.ВладелецФормы.МестныйКэш;
		КонецПопытки;
	КонецЕсли;
	Возврат МестныйКэш.ОбщиеФункции.ЗаполнитьПрохождение(МестныйКэш, СоставПакета, Новый Структура);
КонецФункции

#КонецОбласти

#Область include_local_Раздел_Полученные_Шаблон

&НаКлиенте
Процедура НастроитьКолонки(Кэш) Экспорт
	Кэш.ОбщиеФункции.НастроитьКолонки(Неопределено, Кэш); // alo СтатусГос
	сбисЭлементФормы(Кэш.ГлавноеОкно,"Таблица_РеестрДокументов").ПодчиненныеЭлементы.Таблица_РеестрДокументовСклад.Заголовок = "Подразделение";
КонецПроцедуры
&НаКлиенте
Процедура УстановитьВидимостьЭлементовВформеПросмотра(ФормаПросмотра, СоставПакета, КэшПарам) Экспорт
	ФормаПросмотра.Заголовок = ФормаПросмотра.СоставПакета.Название;
	ФормаПросмотра.ЗаголовокПакета = ФормаПросмотра.СоставПакета.Название;
	ФормаПросмотра.Элементы.Контент.ПодчиненныеЭлементы.Загрузка.Видимость = Истина;
	ФормаПросмотра.Элементы.ТабличнаяЧасть.ПодчиненныеЭлементы.ТабличнаяЧастьИдентификатор.Видимость = Ложь;
	ФормаПросмотра.Элементы.ТабличнаяЧасть.ПодчиненныеЭлементы.ТабличнаяЧастьНоменклатураПоставщика.Видимость = Истина;
	ФормаПросмотра.Элементы.ТабличнаяЧасть.ПодчиненныеЭлементы.ТабличнаяЧастьХарактеристикаПоставщика.Видимость = Истина;
	ФормаПросмотра.Элементы.ТабличнаяЧасть.ПодчиненныеЭлементы.ТабличнаяЧастьЕдИзм.Видимость = Истина;
	ФормаПросмотра.Элементы.ТабличнаяЧасть.ПодчиненныеЭлементы.ТабличнаяЧастьКоличество.Видимость = Истина;
	ФормаПросмотра.Элементы.ТабличнаяЧасть.ПодчиненныеЭлементы.ТабличнаяЧастьЦена.Видимость = Истина;
	ФормаПросмотра.Элементы.ТабличнаяЧасть.ПодчиненныеЭлементы.ТабличнаяЧастьСуммаБезНал.Видимость = Истина;
	ФормаПросмотра.Элементы.ТабличнаяЧасть.ПодчиненныеЭлементы.ТабличнаяЧастьСтавкаНДС.Видимость = Истина;
	ФормаПросмотра.Элементы.ТабличнаяЧасть.ПодчиненныеЭлементы.ТабличнаяЧастьСуммаНДС.Видимость = Истина;
	ФормаПросмотра.Элементы.ТабличнаяЧасть.ПодчиненныеЭлементы.ТабличнаяЧастьСумма.Видимость = Истина;
	ФормаПросмотра.Элементы.СинонимДокумента.Видимость = Истина;
	ФормаПросмотра.Элементы.ТекущийЭтап.Видимость = Истина;
	//Если есть возможность выполнить аннулирование документа, то форма переходов должна быть доступна
	СостояниеПакета = СоставПакета;
	ЕстьАннулирование	= Не	(	СостояниеПакета.Свойство("Состояние", СостояниеПакета)
								И	СостояниеПакета.Свойство("Название", СостояниеПакета)
								И	СостояниеПакета = "Отозван мной");
	ЭтапыПакета		= Неопределено;
	ДействияПакета	= Неопределено;
	Если	СоставПакета.Свойство("Этап", ЭтапыПакета)
		И	ЭтапыПакета.Количество()
		И	ЭтапыПакета[0].Свойство("Действие",ДействияПакета)
		И	ДействияПакета.Количество() Тогда
		ФормаПросмотра.Элементы.ТекущийЭтап.Видимость = Истина;
		ФормаПросмотра.Элементы.ТекущийЭтап.Заголовок = ЭтапыПакета[0].Название;
		ФормаПросмотра.Элементы.Утвердить.Видимость = Истина;
		ФормаПросмотра.Элементы.Утвердить.Заголовок = ДействияПакета[0].Название;
		Если ДействияПакета.Количество() > 1 Тогда
			ФормаПросмотра.Элементы.Отклонить.Видимость = Истина;
			ФормаПросмотра.Элементы.Отклонить.Заголовок = ДействияПакета[1].Название;
		Иначе
			ФормаПросмотра.Элементы.Отклонить.Видимость = Ложь;
		КонецЕсли;
	Иначе
		ФормаПросмотра.Элементы.ТекущийЭтап.Видимость = ЕстьАннулирование;
		ФормаПросмотра.Элементы.Отклонить.Видимость = Ложь;
		ФормаПросмотра.Элементы.Утвердить.Видимость = Ложь;
	КонецЕсли;
	Если Не МестныйКэш = Неопределено Тогда
		МестныйКэш.ГлавноеОкно.СбисПолучитьЭлементФормы(ФормаПросмотра, "ГруппаАбонЯщик").Видимость = Ложь;
	КонецЕсли;
	
	ФормаПросмотра.Элементы.ТулБар.ТекущаяСтраница = сбисПолучитьСтраницу(ФормаПросмотра.Элементы.ТулБар,"Полученные");
	ФормаПросмотра.Элементы.ТаблицаДокументов.ПодчиненныеЭлементы.ТаблицаДокументовСтатус.Видимость = Ложь;
	ФормаПросмотра.Элементы.ТаблицаДокументов.ПодчиненныеЭлементы.ТаблицаДокументовСтатусКартинка.Видимость = Ложь;	
	ФормаПросмотра.Элементы.ТаблицаДокументов.ПодчиненныеЭлементы.ТаблицаДокументовШифрование.Видимость = Ложь;
	ФормаПросмотра.Элементы.ТаблицаДокументов.ПодчиненныеЭлементы.ТаблицаДокументовОтмечен.Видимость = Истина;
	ФормаПросмотра.Элементы.ПакетКомментарий.Доступность = Ложь;
	ФормаПросмотра.Элементы.Контент.ПодчиненныеЭлементы.Прохождение.Видимость = Истина;
	ФормаПросмотра.Элементы.ТаблицаДокументов.ПодчиненныеЭлементы.ТаблицаДокументовУдалить.Видимость = Ложь;
КонецПроцедуры
&НаКлиенте
Процедура ФильтрУстановитьВидимость(ФормаФильтра) Экспорт
	ВыбранныйЭлемент = сбисЭлементФормы(ФормаФильтра,"ФильтрКонтрагентПодключен");
	Если Не ВыбранныйЭлемент = Неопределено Тогда
		ВыбранныйЭлемент.Видимость = Ложь;
	КонецЕсли;
	ВыбранныйЭлемент = сбисЭлементФормы(ФормаФильтра,"ФильтрКонтрагентСФилиалами");
	Если Не ВыбранныйЭлемент = Неопределено Тогда
		ВыбранныйЭлемент.Видимость = Истина;
	КонецЕсли;
	ВыбранныйЭлемент = сбисЭлементФормы(ФормаФильтра,"ФильтрОтветственный");
	Если Не ВыбранныйЭлемент = Неопределено Тогда
		ВыбранныйЭлемент.Видимость = Ложь;
	КонецЕсли;
	ВыбранныйЭлемент = сбисЭлементФормы(ФормаФильтра,"ФильтрТипыДокументов");
	Если Не ВыбранныйЭлемент = Неопределено Тогда
		ВыбранныйЭлемент.Видимость = Ложь;
	КонецЕсли;
КонецПроцедуры
&НаКлиенте
Процедура сбисОформлениеДопПолейРеестра(Кэш) Экспорт
	сбисЭлементФормы(Кэш.ГлавноеОкно,"Таблица_РеестрДокументов").ПодчиненныеЭлементы.Таблица_РеестрДокументовСрок.Видимость = Ложь;
	сбисЭлементФормы(Кэш.ГлавноеОкно,"Таблица_РеестрДокументов").ПодчиненныеЭлементы.Таблица_РеестрДокументовЛицо2.Видимость = Ложь;
	Кэш.ОбщиеФункции.НастроитьКолонки(Неопределено, Кэш);
КонецПроцедуры

#КонецОбласти
