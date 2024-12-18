
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
//------------------------------------------------------
&НаКлиенте
Функция ОбновитьКонтент(Кэш) Экспорт
// функция обновляет контент для подразделов раздела Покупка	
	ИмяРеестра="";	Ини="";
	Если Кэш.Разделы.Покупка.Свойство(Кэш.Текущий.Имя,ИмяРеестра)=Ложь Тогда
		Сообщить("Отсутствует настройка для перехода в раздел. Доступные настройки можно подключить на вкладке ""Настройки/Файлы настроек""");
		Возврат Ложь;
	КонецЕсли;
	Если Кэш.ини.Свойство(ИмяРеестра,Ини)=Ложь Тогда
		Возврат Ложь;
	ИначеЕсли Ини = Неопределено Тогда
		Ини = Кэш.ФормаНастроек.Ини(Кэш, ИмяРеестра);
	КонецЕсли;
	Кэш.Текущий.ТипДок = ИмяРеестра;
	СтруктураДляОбновленияФормы = Кэш.ОбщиеФункции.сбисОбновитьРеестрДокументов1С(Ини, Кэш);
	Кэш.ОбщиеФункции.ОбновитьПанельНавигации(Кэш);
	ГлавноеОкно = Кэш.ГлавноеОкно;
	Контент = сбисЭлементФормы(ГлавноеОкно, "Контент");
	Контент.ТекущаяСтраница = сбисПолучитьСтраницу(Контент, "РеестрДокументов");	
	Кэш.ТаблДок = сбисЭлементФормы(Кэш.ГлавноеОкно,"Таблица_РеестрДокументов");
	
	Кэш.ГлавноеОкно.СписокДопОперацийРеестра.Очистить();
	сбисЭлементФормы(Кэш.ГлавноеОкно,"ДопОперации3").Видимость = Ложь;
	Если Ини.Свойство("ДопОперацияРеестра")  Тогда
		Для Каждого ДопОперация Из Ини.ДопОперацияРеестра Цикл
			Кэш.ГлавноеОкно.СписокДопОперацийРеестра.Добавить(ДопОперация.Значение.Операция.Функция1С, Кэш.ОбщиеФункции.РассчитатьЗначение("Операция", ДопОперация.Значение, Кэш));
			сбисЭлементФормы(Кэш.ГлавноеОкно,"ДопОперации3").Видимость = Истина;
		КонецЦикла;
	КонецЕсли;

	Возврат СтруктураДляОбновленияФормы;
КонецФункции
&НаКлиенте
Процедура НастроитьКолонки(Кэш) Экспорт
	ИмяРеестра="";	Ини="";
	Если Кэш.Разделы.Покупка.Свойство(Кэш.Текущий.Имя,ИмяРеестра)=Ложь Тогда
		Сообщить("Отсутствует настройка для перехода в раздел. Доступные настройки можно подключить на вкладке ""Настройки/Файлы настроек""");
		Возврат;
	КонецЕсли;
	Если Кэш.ини.Свойство(ИмяРеестра,Ини)=Ложь Тогда
		Возврат;
	ИначеЕсли Ини = Неопределено Тогда
		Ини = Кэш.ФормаНастроек.Ини(Кэш, ИмяРеестра);
	КонецЕсли;
	Кэш.ОбщиеФункции.НастроитьКолонки(Ини, Кэш); // alo СтатусГос
	сбисЭлементФормы(Кэш.ГлавноеОкно,"Таблица_РеестрДокументов").ПодчиненныеЭлементы.Таблица_РеестрДокументовСклад.Заголовок = "Склад";
	Кэш.ГлавноеОкно.СбисПолучитьЭлементФормы(Кэш.ГлавноеОкно, Кэш.ГлавноеОкно.СбисПолноеИмяКолонки("Таблица_РеестрДокументов",	"Ответственный")).Видимость = Ложь;
КонецПроцедуры
&НаКлиенте
Процедура НавигацияУстановитьПанель(Кэш) Экспорт
// Процедура устанавливает панель навигации на 1ую страницу и скрывает панель	
	ГлавноеОкно = Кэш.ГлавноеОкно;
	сбисЭлементФормы(ГлавноеОкно,"ПанельНавигации").Видимость=Истина;
	сбисЭлементФормы(ГлавноеОкно,"ЗаписейНаСтранице1С").Видимость=Истина;
	сбисЭлементФормы(ГлавноеОкно,"ЗаписейНаСтранице").Видимость=Ложь;
КонецПроцедуры	
&НаКлиенте
Процедура ПоказатьДокумент(Кэш, СтрТабл) Экспорт
// Процедура открывает окно просмотра документа		
	ГлавноеОкно = Кэш.ГлавноеОкно;
	Кэш.СписокНоменклатуры.Очистить();
	МассивПакетов = ПодготовитьСтруктуруДокумента(СтрТабл, Кэш);
	Если МассивПакетов.Количество() = 1 Тогда
		ПолныйСоставПакета = МассивПакетов[0];
		Если ПолныйСоставПакета.Свойство("Вложение") Тогда
			Для Каждого Элемент Из ПолныйСоставПакета.Вложение Цикл
				Если ЗначениеЗаполнено(Элемент.XMLДокумента) Тогда
					ТекстHTML = Кэш.Интеграция.ПолучитьHTMLПоXML(Кэш, Элемент);
				Иначе
					ТекстHTML = "";
				КонецЕсли;
				Элемент.Вставить("ТекстHTML",ТекстHTML);
			КонецЦикла;
			фрм = ГлавноеОкно.сбисНайтиФормуФункции("ПоказатьДокумент","ФормаПросмотрДокумента","", Кэш);
			фрм.ПоказатьДокумент(Кэш,ПолныйСоставПакета);	
		КонецЕсли;
	ИначеЕсли МассивПакетов.Количество() > 1 Тогда
		фрм = ГлавноеОкно.сбисНайтиФормуФункции("ПоказатьДокументы","ФормаПросмотрДокументов","", Кэш);
		фрм.ПоказатьДокументы(Кэш, МассивПакетов);
	КонецЕсли;
КонецПроцедуры
&НаКлиенте
Процедура НаСменуРаздела(Кэш) Экспорт
	// Процедура обновляет панель массовых операций, панель фильтра, контекстное меню при смене раздела			
	фрм = Кэш.ГлавноеОкно.сбисНайтиФормуФункции("НаСменуРаздела","Раздел_Покупка_Покупка","", Кэш);
	фрм.НаСменуРаздела(Кэш);
КонецПроцедуры
&НаКлиенте
Функция ПодготовитьСтруктуруДокумента(СтрокаСпискаДокументов, Кэш) Экспорт
// Функция готовит структуру пакета электронных документов по комплекту документов 1С для просмотра и отправки контрагентам.	
	Возврат Кэш.ОбщиеФункции.ПодготовитьСтруктуруДокумента1С(СтрокаСпискаДокументов, Кэш);	
КонецФункции
&НаКлиенте
Функция ПодготовитьСтруктуруДокументаДляРасхождений(СтрокаСпискаДокументов, Кэш) Экспорт
	Перем СтруктураИниФайла, СтруктураФайла, мДокументы, СтруктураДокументаПоДаннымСбис, СтруктураДокументаПоДанным1С;
	Соответствие = Новый Соответствие();
	КэшПакетов = Новый Структура("Успешно, Ошибки", Новый Соответствие(), Новый Соответствие());
	
	МассивПакетов = Кэш.СБИС.МодульОбъектаКлиент.ПодготовитьСтруктуруДокумента1СДляРасхождений(СтрокаСпискаДокументов, Кэш);
	
	Для каждого Пакет Из МассивПакетов Цикл
		Для Каждого ВложениеПакета Из Пакет.Вложение Цикл
			СтруктураДокументаПоДанным1С = ВложениеПакета.СтруктураФайла.Файл.Документ;
			
			ИдДок = Кэш.ОбщиеФункции.ИдентификаторСБИСПоДокументу(Кэш, ВложениеПакета.Документы1С[0].Значение);
			Если Не ЗначениеЗаполнено(ИдДок) Тогда
				Сообщить("Не удалось получить документ СБИС");
				Продолжить;
			КонецЕсли;
			
			Если Не КэшПакетов.Ошибки.Получить(ИдДок) = Неопределено Тогда
				 Сообщить("Не удалось получить вложение СБИС"); 
				Продолжить;
			КонецЕсли;
			
			ПолныйСоставПакетаСбис = КэшПакетов.Успешно.Получить(ИдДок);
			Если ПолныйСоставПакетаСбис = Неопределено Тогда 
				Попытка
					ПараметрыДокумента = Кэш.Интеграция.СБИС_ПолучитьПараметрыПакетаДляОткрытияОнлайн(Новый Структура("ИдДок", ИдДок), Новый Структура("Кэш", Кэш));
					ДопПарам = Новый Структура("СообщатьПриОшибке, ВернутьОшибку", Ложь, Истина);
					СоставПакетаСбис = Кэш.Интеграция.ПрочитатьДокумент(Кэш,ПараметрыДокумента.ИдДокумента, ДопПарам);	
										
					ПолныйСоставПакетаСбис = Кэш.ОбщиеФункции.РазобратьСтруктуруДокументаСбис(СоставПакетаСбис, Кэш); //только по вложению сбис	
					
					ВложениеСбис = Кэш.СБИС.МодульОбъектаКлиент.НайтиВложениеСбисПоВложению1С(Новый Структура("СоставПакетаСбис,Вложение1С",СоставПакетаСбис, ВложениеПакета), Новый Структура("Кэш", Кэш));
					СтруктураДокументаПоДаннымСбис = ВложениеСбис.СтруктураФайла.Файл.Документ;  
					КэшПакетов.Успешно.Вставить(ИдДок, ПолныйСоставПакетаСбис);
				Исключение
					КэшПакетов.Ошибки.Вставить(ИдДок, ПолныйСоставПакетаСбис);
				КонецПопытки;
			Иначе
				Попытка
					ВложениеСбис = Кэш.СБИС.МодульОбъектаКлиент.НайтиВложениеСбисПоВложению1С(Новый Структура("СоставПакетаСбис,Вложение1С",СоставПакетаСбис, ВложениеПакета), Новый Структура("Кэш", Кэш));
                	СтруктураДокументаПоДаннымСбис = ВложениеСбис.СтруктураФайла.Файл.Документ;
				Исключение
					СтруктураДокументаПоДаннымСбис = Неопределено;
				КонецПопытки;
			КонецЕсли;
			
			Если Не СтруктураДокументаПоДаннымСбис = Неопределено Тогда
				Соответствие.Вставить(ВложениеПакета.Название, Новый Структура("СтруктураДокументаПоДаннымСбис, СтруктураДокументаПоДанным1С", СтруктураДокументаПоДаннымСбис, СтруктураДокументаПоДанным1С));
			КонецЕсли;	
			
		КонецЦикла;
	КонецЦикла;
	Возврат Соответствие;	
КонецФункции
&НаКлиенте
Процедура ФильтрОчистить(Кэш) Экспорт
// Процедура устанавливает значения фильтра по-умолчанию для текущего раздела	
	ГлавноеОкно = Кэш.ГлавноеОкно;
	Если ТипЗнч(ЭтаФорма) = Тип("УправляемаяФорма") Тогда
		ГлавноеОкно.ФильтрПериод = "За последний месяц";
	Иначе
		ГлавноеОкно.ФильтрПериод = "1";
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
	ГлавноеОкно.ФильтрДатаНач = ДобавитьМесяц(ТекущаяДата(),-1);
	ГлавноеОкно.ФильтрДатаКнц = ТекущаяДата();
	ГлавноеОкно.ФильтрСостояние = ГлавноеОкно.СписокСостояний.НайтиПоИдентификатору(0).Значение;
	ГлавноеОкно.ФильтрКонтрагентПодключен = "";
	ГлавноеОкно.ФильтрКонтрагентСФилиалами = Ложь;
	ГлавноеОкно.ФильтрСтраница = 1;
	ГлавноеОкно.ФильтрМаска = "";
	//Очистим дополнительные параметры фильтра
	НазваниеРаздела = Кэш.Разделы["р"+Кэш.Текущий.Раздел];
	ФормаДопФильтра = ГлавноеОкно.сбисНайтиФормуФункции("сбисСписокДопПараметровФильтра","Фильтр_Раздел_"+НазваниеРаздела+"_"+Кэш.Текущий.ТипДок,"Фильтр_Раздел_"+НазваниеРаздела+"_Шаблон", Кэш);
	Если ФормаДопФильтра<>ложь Тогда
		ГлавноеОкно.ОчиститьДополнительныеПараметрыФильтра(ФормаДопФильтра);	
	КонецЕсли;
КонецПроцедуры
&НаКлиенте
Процедура УстановитьВидимостьЭлементовВформеПросмотра(ФормаПросмотра, СоставПакета, КэшПарам) Экспорт
	ФормаПросмотра.ДокументРазобран = Истина;
	СопоставлятьНоменклатуруПередОтправкой = Ложь;
	Если СоставПакета.Свойство("Вложение") Тогда
		Для Каждого Вложение Из СоставПакета.Вложение Цикл
			Если Вложение.Свойство("НоменклатураКодКонтрагента") Тогда
				СопоставлятьНоменклатуруПередОтправкой = Истина;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	Если		МестныйКэш = Неопределено
		И Не	ЭтаФорма.ВладелецФормы = Неопределено Тогда
		МестныйКэш = ЭтаФорма.ВладелецФормы.Кэш;
	КонецЕсли;
	Если Не МестныйКэш = Неопределено Тогда
		МестныйКэш.ГлавноеОкно.СбисПолучитьЭлементФормы(ФормаПросмотра, "ГруппаАбонЯщик").Видимость = Истина;
	КонецЕсли;
	Если СопоставлятьНоменклатуруПередОтправкой Тогда
		ФормаПросмотра.Элементы.Контент.ПодчиненныеЭлементы.Загрузка.Видимость = Истина;
		ФормаПросмотра.Элементы.ТабличнаяЧасть.ПодчиненныеЭлементы.ТабличнаяЧастьИдентификатор.Видимость = Истина;
		ФормаПросмотра.Элементы.ТабличнаяЧасть.ПодчиненныеЭлементы.ТабличнаяЧастьНоменклатураПоставщика.Видимость = Ложь;
		ФормаПросмотра.Элементы.ТабличнаяЧасть.ПодчиненныеЭлементы.ТабличнаяЧастьХарактеристикаПоставщика.Видимость = Ложь;
		ФормаПросмотра.Элементы.ТабличнаяЧасть.ПодчиненныеЭлементы.ТабличнаяЧастьЕдИзм.Видимость = Ложь;
		ФормаПросмотра.Элементы.ТабличнаяЧасть.ПодчиненныеЭлементы.ТабличнаяЧастьКоличество.Видимость = Ложь;
		ФормаПросмотра.Элементы.ТабличнаяЧасть.ПодчиненныеЭлементы.ТабличнаяЧастьЦена.Видимость = Ложь;
		ФормаПросмотра.Элементы.ТабличнаяЧасть.ПодчиненныеЭлементы.ТабличнаяЧастьСуммаБезНал.Видимость = Ложь;
		ФормаПросмотра.Элементы.ТабличнаяЧасть.ПодчиненныеЭлементы.ТабличнаяЧастьСтавкаНДС.Видимость = Ложь;
		ФормаПросмотра.Элементы.ТабличнаяЧасть.ПодчиненныеЭлементы.ТабличнаяЧастьСуммаНДС.Видимость = Ложь;
		ФормаПросмотра.Элементы.ТабличнаяЧасть.ПодчиненныеЭлементы.ТабличнаяЧастьСумма.Видимость = Ложь;
		ФормаПросмотра.Элементы.СинонимДокумента.Видимость = Ложь;
	Иначе
		ФормаПросмотра.Элементы.Контент.ПодчиненныеЭлементы.Загрузка.Видимость = Ложь;	
	КонецЕсли;
	ФормаПросмотра.Заголовок = строка(ФормаПросмотра.СоставПакета.Вложение[0].Документы1С[0].Значение);
	ФормаПросмотра.ЗаголовокПакета = строка(ФормаПросмотра.СоставПакета.Вложение[0].Документы1С[0].Значение);
	ФормаПросмотра.Элементы.Контент.ПодчиненныеЭлементы.Прохождение.Видимость = Ложь;
	ФормаПросмотра.Элементы.ТаблицаДокументов.ПодчиненныеЭлементы.ТаблицаДокументовСтатус.Видимость = Ложь;
	ФормаПросмотра.Элементы.ТаблицаДокументов.ПодчиненныеЭлементы.ТаблицаДокументовСтатусКартинка.Видимость = Ложь;
	ФормаПросмотра.Элементы.ТаблицаДокументов.ПодчиненныеЭлементы.ТаблицаДокументовУдалить.Видимость = Истина;
	ФормаПросмотра.Элементы.ТаблицаДокументов.ПодчиненныеЭлементы.ТаблицаДокументовШифрование.Видимость = (КэшПарам.ШифроватьВыборочно = Истина И (КэшПарам.СпособОбмена=5 Или КэшПарам.СпособОбмена=7));
	ФормаПросмотра.Элементы.ТаблицаДокументов.ПодчиненныеЭлементы.ТаблицаДокументовОтмечен.Видимость = Ложь;
	ФормаПросмотра.Элементы.ПакетКомментарий.Доступность = Истина;
	ФормаПросмотра.Элементы.ТулБар.ТекущаяСтраница = сбисПолучитьСтраницу(ФормаПросмотра.Элементы.ТулБар,"Продажа");
КонецПроцедуры
&НаКлиенте
Функция сбисСписокДополнительныхОпераций(Кэш, ФормаПросмотра) Экспорт
	СписокДопОпераций = Новый СписокЗначений;
	СписокДопОпераций.Добавить("СохранитьНаДиск", "Сохранить на диск");
	СписокДопОпераций.Добавить("ОткрытьКонтрагентаОнлайнПоПакету", "Открыть контрагента на sbis.ru");
	ФормаПросмотра.СервисДопОперацияПросмотра(СписокДопОпераций);	// alo доп операции из инишки Сервис
	Ини = Кэш.ФормаНастроек.Ини(Кэш, Кэш.Текущий.ТипДок);
	Если Ини.Свойство("ДопОперацияПросмотра")  Тогда
		Для Каждого ДопОперация Из Ини.ДопОперацияПросмотра Цикл
			СписокДопОпераций.Добавить(ДопОперация.Значение.Операция.Функция1С, Кэш.ОбщиеФункции.РассчитатьЗначение("Операция", ДопОперация.Значение, Кэш));
		КонецЦикла;
	КонецЕсли;
	Возврат СписокДопОпераций;
КонецФункции
&НаКлиенте
Функция СохранитьНаДиск(Кэш, ФормаПросмотра) Экспорт
	ФормаПросмотра.СохранитьНаДискНажатие("");
КонецФункции
&НаКлиенте
Процедура ФильтрУстановитьВидимость(ФормаФильтра) Экспорт
	ВыбранныйЭлемент = сбисЭлементФормы(ФормаФильтра,"ФильтрКонтрагентПодключен");
	Если Не ВыбранныйЭлемент = Неопределено Тогда
		ВыбранныйЭлемент.Видимость = Истина;
	КонецЕсли;
	ВыбранныйЭлемент = сбисЭлементФормы(ФормаФильтра,"ФильтрКонтрагентСФилиалами");
	Если Не ВыбранныйЭлемент = Неопределено Тогда
		ВыбранныйЭлемент.Видимость = Ложь;
	КонецЕсли;
	ВыбранныйЭлемент = сбисЭлементФормы(ФормаФильтра,"ФильтрОтветственный");
	Если Не ВыбранныйЭлемент = Неопределено Тогда
		ВыбранныйЭлемент.Видимость = Истина;
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
КонецПроцедуры