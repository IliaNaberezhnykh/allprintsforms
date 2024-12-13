
&НаКлиенте
Перем МестныйКэш Экспорт;
&НаКлиенте
Перем ЕстьИзменения Экспорт;
&НаКлиенте
Перем ПоследнееИзменение Экспорт;
// функции для совместимости кода 
&НаКлиенте
Функция сбисПолучитьФорму(СбисИмяФормы)
	Возврат ВладелецФормы.сбисПолучитьФорму(СбисИмяФормы);
КонецФункции
&НаКлиенте
Функция сбисЭлементФормы(Форма,ИмяЭлемента)
	Если ТипЗнч(ЭтаФорма) = Тип("УправляемаяФорма") Тогда
		Возврат Форма.Элементы.Найти(ИмяЭлемента);
	КонецЕсли;
	Возврат Форма.ЭлементыФормы.Найти(ИмяЭлемента);;
КонецФункции
&НаКлиенте
Процедура сбисПоказатьСостояние(ТекстСостояния, Форма = Неопределено, Индикатор = Неопределено, Пояснение = "")
	Если ТипЗнч(ЭтаФорма) = Тип("УправляемаяФорма") Тогда
		Состояние(ТекстСостояния,Индикатор,Пояснение);
	Иначе
		Форма.ЭлементыФормы.ПанельОжидания.Видимость = Истина;
		Форма.НадписьОжидания = Символы.ПС + ТекстСостояния;
		Форма.НадписьПояснение = Пояснение;
		Если Индикатор<>Неопределено Тогда
			Форма.ЭлементыФормы.Индикатор.Видимость = Истина;
			Форма.ЭлементыФормы.Индикатор.Значение = Индикатор;
		КонецЕсли;
	КонецЕсли;	
КонецПроцедуры
&НаКлиенте
Процедура сбисСпрятатьСостояние(Форма = Неопределено)
	Если ТипЗнч(ЭтаФорма) = Тип("УправляемаяФорма") Тогда
	Иначе
		Форма.ЭлементыФормы.ПанельОжидания.Видимость = Ложь;
		Форма.ЭлементыФормы.Индикатор.Видимость = Ложь;
	КонецЕсли;	
КонецПроцедуры

//------------------------------------------------------

// Заглушка (SDK)
&НаКлиенте
Функция ВключитьОтладку(Кэш, КаталогОтладки) Экспорт
КонецФункции
// Заглушка (SDK)
&НаКлиенте
Функция ОтключитьОтладку(Кэш) Экспорт
КонецФункции
// Изменяет каталог отладки с соответствующими проверками
&НаКлиенте
Функция УстановитьКаталогОтладки(Кэш) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.УстановитьКаталогОтладки(Кэш);
КонецФункции
&НаКлиенте
Функция ЗакрытьСессию(Кэш) Экспорт 	
	// Закрывает сессию	
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.ЗакрытьСессию(Кэш);
КонецФункции	
&НаКлиенте
Функция АвторизоватьсяПоЛогинуПаролю(Кэш,Логин,Пароль,Отказ=Ложь) Экспорт 	
	// Авторизуется на online.sbis.ru по логину/паролю	
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.АвторизоватьсяПоЛогинуПаролю(Кэш,Логин,Пароль,Отказ);
КонецФункции	
&НаКлиенте
Функция АвторизоватьсяПоСертификату(Кэш,Сертификат,Отказ=Ложь) Экспорт
	// Авторизуется на online.sbis.ru по сертификату	
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.АвторизоватьсяПоСертификату(Кэш,Сертификат,Отказ);
КонецФункции
&НаКлиенте
Функция АвторизоватьсяПоТокену(Кэш,Отказ=Ложь) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.АвторизоватьсяПоТокену(Кэш,Отказ);
КонецФункции
&НаКлиенте
функция ПолучитьТикетДляТекущегоПользователя(Кэш) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.ПолучитьТикетДляТекущегоПользователя(Кэш);
КонецФункции
&НаКлиенте
Функция ПодтвердитьАвторизацию(Кэш, ПараметрыВвода, ПараметрыПодтверждения, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.ПодтвердитьАвторизацию(Кэш,ПараметрыВвода,ПараметрыПодтверждения,Отказ);
КонецФункции
&НаКлиенте
Функция ОтправитьКодАвторизации(Кэш, ПараметрыПодтверждения, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.ОтправитьКодАвторизации(Кэш,ПараметрыПодтверждения,Отказ);
КонецФункции
&НаКлиенте
Функция СформироватьНастройкиПодключения(Кэш, ИдентификаторСессии = "") Экспорт
	// Устанавливает в SDK настройки подключения		
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.СформироватьНастройкиПодключения(Кэш, ИдентификаторСессии = "");
КонецФункции
&НаКлиенте
Функция ПолучитьНастройкиПлагина(Кэш, ДополнительныеПараметрыЗапроса=Неопределено, Отказ=Ложь) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.ПолучитьНастройкиПлагина(Кэш, ДополнительныеПараметрыЗапроса, Отказ);	
КонецФункции
&НаКлиенте
Функция сбисУстановитьВремяОжидания(Кэш, ВремяОжидания) Экспорт
	Кэш.СБИС.ПараметрыИнтеграции.Вставить("ВремяОжиданияОтвета", ВремяОжидания);
КонецФункции
&НаКлиенте
Функция ПолучитьСписокСертификатовДляАвторизации(Кэш,ТекстОшибки) Экспорт
	// Получает список сертификатов для авторизации	
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.ПолучитьСписокСертификатовДляАвторизации(Кэш,ТекстОшибки);
КонецФункции
&НаКлиенте
Функция ПолучитьСписокСертификатов(Кэш, filter=Неопределено) Экспорт
	// Получает список доступных сертификатов	
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.ПолучитьСписокСертификатов(Кэш, filter);
КонецФункции
&НаКлиенте
функция ПолучитьСертификатыДляАктивации(Кэш, СписокИНН) Экспорт
	// функция активирует серверные сертификаты для определенного списка ИНН	
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.ПолучитьСертификатыДляАктивации(Кэш, СписокИНН);
КонецФункции
&НаКлиенте
Функция ПолучитьКодАктивацииСертификата(Кэш, Сертификат) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.ПолучитьКодАктивацииСертификата(Кэш, Сертификат);
КонецФункции
&НаКлиенте
функция АктивироватьСерверныеСертификаты(Кэш, СписокСертификатов) Экспорт
	// функция активирует серверные сертификаты для определенного списка ИНН	
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.АктивироватьСерверныеСертификаты(Кэш, СписокСертификатов);
КонецФункции
&НаКлиенте
Функция ИнформацияОТекущемПользователе(Кэш) Экспорт
	// Получает информацию о текущем пользователе	
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.ИнформацияОТекущемПользователе(Кэш);
КонецФункции
&НаКлиенте
Функция сбисСессияДействительна(Кэш) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.сбисСессияДействительна(Кэш);
КонецФункции
&НаКлиенте
Функция СбисИдАккаунта(Кэш) Экспорт
	Возврат Неопределено;
КонецФункции
&НаКлиенте
Функция ПолучитьИдТекущегоАккаунта(Кэш) Экспорт
	Возврат Неопределено;
КонецФункции
&НаКлиенте
Функция ПолучитьСписокДокументовОтгрузки(Кэш) Экспорт
	// Получает список документов реализации с online.sbis.ru 	
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.ПолучитьСписокДокументовОтгрузки(Кэш);
КонецФункции
&НаКлиенте
Функция ПолучитьСписокСобытий(Кэш, ТипРеестра) Экспорт
	// Получает список документов по событиям с online.sbis.ru	
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.ПолучитьСписокСобытий(Кэш, ТипРеестра);
КонецФункции
&НаКлиенте
Функция ПолучитьСписокСобытийПоФильтру(Кэш, filter, ГлавноеОкно) Экспорт
	// Получает список документов по событиям с online.sbis.ru	
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.ПолучитьСписокСобытийПоФильтру(Кэш, filter, ГлавноеОкно);
КонецФункции
&НаКлиенте
Функция сбисПолучитьСписокДокументов(Кэш) Экспорт
	// Получает список документов определенного типа с online.sbis.ru	
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.сбисПолучитьСписокДокументов(Кэш);
КонецФункции
&НаКлиенте
Функция сбисПолучитьСписокЗадач(Кэш, сбисФильтр, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.сбисПолучитьСписокЗадач(Кэш, сбисФильтр, Отказ);
КонецФункции
&НаКлиенте
функция ПрочитатьДокумент(Кэш,ИдДок,ДопПараметры=Неопределено,Отказ=Ложь) экспорт
	// Получает структуру документа СБИС
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.ПрочитатьДокумент(Кэш,ИдДок,ДопПараметры,Отказ);
КонецФункции
&НаКлиенте
функция ПолучитьДанныеФайла(Кэш,Ссылка) экспорт
	// Получает данные файла вложения	
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.ПолучитьДанныеФайла(Кэш,Ссылка);
КонецФункции
&НаКлиенте
функция ПолучитьДанныеЗашифрованногоФайла(Кэш,Ссылка) экспорт
	// Получает данные файла вложения	
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.ПолучитьДанныеЗашифрованногоФайла(Кэш,Ссылка);
КонецФункции
&НаКлиенте
функция ПроверитьПодписиВложения(Кэш,Вложение) экспорт
	// Расшифровывает данные файла вложения	
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.ПроверитьПодписиВложения(Кэш,Вложение);
КонецФункции
&НаКлиенте
функция СохранитьВложениеПоСсылкеВФайл(Кэш,Ссылка,ИмяФайла) экспорт //d.ch
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.СохранитьВложениеПоСсылкеВФайл(Кэш,Ссылка,ИмяФайла);
КонецФункции
&НаКлиенте
функция ПолучитьHTMLВложения(Кэш,ИдДок, Вложение) экспорт
	// Получает html по идентификаторам пакета и вложения
	// Используется при просмотре документов из реестров СБИС
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.ПолучитьHTMLВложения(Кэш,ИдДок, Вложение);
КонецФункции
&НаКлиенте
функция ПолучитьHTMLПоXML(Кэш, Вложение) экспорт
	// Получает html по xml	
	Отказ = Ложь;
	ДопПараметрыЗапроса	= Новый Структура("ЕстьРезультат", Истина);
	
	document = Новый Структура( "XML, Тип, Подтип, ВерсияФормата, ПодВерсияФормата", Вложение.XMLДокумента);
	document.Тип = ?(Вложение.Свойство("Тип"), Вложение.Тип, "");
	document.Подтип = ?(Вложение.Свойство("ПодТип"), Вложение.ПодТип, "");
	document.ВерсияФормата = ?(Вложение.Свойство("ВерсияФормата"), Вложение.ВерсияФормата, "");
	document.ПодВерсияФормата = ?(Вложение.Свойство("ПодВерсияФормата") и ЗначениеЗаполнено(Вложение.ПодВерсияФормата), Вложение.ПодВерсияФормата, "");
	
	РезультатЗапроса = Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.сбисОтправитьИОбработатьКоманду(Кэш, "GenerateHTMLFromXMLClient", document, ДопПараметрыЗапроса, Отказ);
	Если Отказ Тогда
		Возврат "";
	КонецЕсли;
	Возврат РезультатЗапроса.HTML;
КонецФункции
&НаКлиенте
Функция сбисВыполнитьКоманду(Кэш, Идентификатор,ИмяКоманды, ПредставлениеПакета) Экспорт
	// Выполняет указанную команду по документу СБИС (утверждение/отклонение)	
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.сбисВыполнитьКоманду(Кэш, Идентификатор,ИмяКоманды, ПредставлениеПакета)
КонецФункции
&НаКлиенте
Функция сбисВыполнитьДействие(Кэш, СоставПакета, Этап, Действие, Комментарий, ПредставлениеПакета) Экспорт
	// Выполняет указанное действие по документу СБИС
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.сбисВыполнитьДействие(Кэш, СоставПакета, Этап, Действие, Комментарий, ПредставлениеПакета);
КонецФункции
//Заглушка, подписание в СБИС Плагине
&НаКлиенте
Функция сбисПодписатьВложения(Кэш, attachmentList, СертификатДляПодписания, Алгоритм, Отказ) Экспорт 
	Возврат Ложь;
КонецФункции
// Переводит документ повторно на ранее выполненный этап
&НаКлиенте
Функция сбисПовторитьЭтап(Кэш, ИдДок, ЭтапНазвание, Отказ=Ложь) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.сбисПовторитьЭтап(Кэш, ИдДок, ЭтапНазвание, Отказ);
КонецФункции
&НаКлиенте
Функция ОбработкаСлужебныхДокументов(Кэш) Экспорт
	// Получает список организаций с необработанными этапами и запускает для них обработку служебных документов
	Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.ОбработкаСлужебныхДокументов(Кэш)	
КонецФункции
&НаКлиенте
Функция ПолучитьИнформациюОКонтрагенте(Кэш, СтруктураКонтрагента) Экспорт
	// Получает Информацию о контрагенте с онлайна
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.ПолучитьИнформациюОКонтрагенте(Кэш, СтруктураКонтрагента);
КонецФункции
&НаКлиенте
функция сбисТекущаяДатаМСек(Кэш) экспорт
	// Получает текущую дату в миллисекундах с начала 1970г
	Отказ				= Ложь;
	ДопПараметрыЗапроса	= Новый Структура("ЕстьРезультат, ВремяОжиданияОтвета", Истина, 30);
	
	Результат = Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.сбисОтправитьИОбработатьКоманду(Кэш, "getMillisecondsSinceEpoch", Новый Структура, ДопПараметрыЗапроса, Отказ);
	Если Отказ Тогда
		Возврат 0;
	КонецЕсли;
	Попытка
		Результат = Число(Результат);
	Исключение
		Возврат 0;
	КонецПопытки;
	Возврат Результат;
КонецФункции
/////////////////////////////////////
&НаКлиенте
Функция ПолучитьСписокИзменений(Кэш, ДопПараметрыФильтра = Неопределено) Экспорт
	// Получает статусы документов сбис
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.ПолучитьСписокИзменений(Кэш, ДопПараметрыФильтра);
КонецФункции
&НаКлиенте
Функция ПолучитьСписокНашихОрганизаций(Кэш, СписокИНН) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.ПолучитьСписокНашихОрганизаций(Кэш, СписокИНН);
КонецФункции

&НаКлиенте
функция ОтправитьКаталогТоваров(Кэш,КаталогТоваров) экспорт
	// Получает структуру документа СБИС	
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.ОтправитьКаталогТоваров(Кэш,КаталогТоваров);
КонецФункции

&НаКлиенте
функция сбисЭмитироватьКМ(Кэш, ИдДок, ДополнительныеПараметры=Неопределено, Отказ=Ложь) экспорт
	// Получает структуру документа СБИС	
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.сбисЭмитироватьКМ(Кэш, ИдДок, ДополнительныеПараметры, Отказ);
КонецФункции

&НаКлиенте
функция сбисЗарегистрироватьВГоссистеме(Кэш, ИдДок, ДополнительныеПараметры=Неопределено, Отказ=Ложь) экспорт
	// Получает структуру документа СБИС	
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.сбисЗарегистрироватьВГоссистеме(Кэш, ИдДок, ДополнительныеПараметры, Отказ);
КонецФункции


//////////////// Вспомогательные функции/////////////////////
&НаКлиенте
Функция Включить(Кэш, ДопПараметры=Неопределено, Отказ=Ложь) Экспорт
	// Добавляет СБИСПлагин в Кэш
	ФормаExtSDK = Кэш.ГлавноеОкно.сбисПолучитьФорму("ExtSDK");
	Возврат ФормаExtSDK.Включить(Кэш, ДопПараметры, Отказ);
КонецФункции
&НаКлиенте
Функция Завершить(Кэш, ДопонительныеПараметры, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.Завершить(Кэш, ДопонительныеПараметры, Отказ);
КонецФункции
&НаКлиенте
Функция СокращенноеФИО(Кэш, ФИО)
	// Формирует сокращенное ФИО из полного	
	ФИО = Кэш.ОбщиеФункции.РазбитьСтрокуВМассивНаКлиенте(ФИО," ");
	
	Фамилия  = ?(ФИО.Количество()>0,ФИО[0],"");
	Имя      = ?(ФИО.Количество()>=2,Лев(ФИО[1],1)+".","");
	Отчество = ?(ФИО.Количество()>=3,Лев(ФИО[2],1)+".","");
	Возврат Фамилия+" "+Имя+Отчество;
КонецФункции
//&НаСервереБезКонтекста
Функция ПолучитьРеквизитОбъекта(Объект1С, ИмяРеквизита)
	// Получает значение реквизита объекта 1С	
	Возврат Объект1С[ИмяРеквизита];	
КонецФункции
&НаКлиенте
Функция СБИСПлагин_ВыполнитьМетод(Кэш, Метод, Парам=Неопределено, ДопПараметры=Неопределено) Экспорт
	Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.СБИСПлагин_ВыполнитьМетод(Кэш, Метод, Парам, ДопПараметры);
КонецФункции
//&НаСервереБезКонтекста
функция сбисСтрокаВBASE64(строка, кодировка = "windows-1251") экспорт
	ТекстДок = Новый ТекстовыйДокумент;
	ТекстДок.УстановитьТекст(строка);
	ИмяВрФ = КаталогВременныхФайлов()+"sbisTemp.xml";
	ТекстДок.Записать(ИмяВрФ, кодировка);
	ТекстXMLBase64 = сбисФайлВBASE64(ИмяВрФ);  
	Попытка 
		УдалитьФайлы(ИмяВрФ); 
	Исключение 
	КонецПопытки;	
	Возврат ТекстXMLBase64;
КонецФункции
//&НаСервереБезКонтекста
функция сбисBASE64ВСтроку(ТекстXMLBase64) экспорт
	ДвоичныеДанныеXML = Base64Значение(ТекстXMLBase64);
	ИмяВрФ = КаталогВременныхФайлов()+"sbisTemp.xml";
	ДвоичныеДанныеXML.Записать(ИмяВрФ);
	ТекстДок = Новый ТекстовыйДокумент;
	ТекстДок.Прочитать(ИмяВрФ);
	html_text = ТекстДок.ПолучитьТекст();
	Попытка 
		УдалитьФайлы(ИмяВрФ); 
	Исключение 
	КонецПопытки;
	Возврат html_text;
КонецФункции
//&НаСервереБезКонтекста
функция сбисФайлВBASE64(ПолноеИмяФайла) экспорт
	ДвоичныеДанныеXML = Новый ДвоичныеДанные(ПолноеИмяФайла);
	ТекстXMLBase64 = СтрЗаменить(СтрЗаменить(Base64Строка(ДвоичныеДанныеXML),Символы.ПС,""),Символы.ВК,"");  
	Возврат ТекстXMLBase64;
КонецФункции
&НаКлиенте
функция сбисФайлСКлиентаВBASE64(ПолноеИмяФайла) экспорт
	# Если НЕ ВебКлиент Тогда
		ДвоичныеДанные = Новый ДвоичныеДанные(ПолноеИмяФайла);
		Возврат сбисФайлНаСервереВBASE64(ДвоичныеДанные);
	# Иначе
		ПомещаемыеФайлы = Новый Массив;
		ПомещаемыеФайлы.Добавить(Новый ОписаниеПередаваемогоФайла(ПолноеИмяФайла,""));
		ПомещенныеФайлы = Новый Массив;
		Попытка
			ПоместитьФайлы(ПомещаемыеФайлы,ПомещенныеФайлы,,Ложь, УникальныйИдентификатор);
			Возврат сбисФайлНаСервереВBASE64(ПомещенныеФайлы, Истина);
		Исключение
			Ошибка = ОписаниеОшибки();
		КонецПопытки;
	# КонецЕсли
	Возврат "";
КонецФункции
//&НаСервереБезКонтекста
функция сбисФайлНаСервереВBASE64(Данные, ЭтоВебКлиент = Ложь) экспорт
	Если ЭтоВебКлиент Тогда
		ДвоичныеДанные = ПолучитьИзВременногоХранилища(Данные[0].Хранение);
	Иначе
		ДвоичныеДанные = Данные;
	КонецЕсли;
	Возврат Base64Строка(ДвоичныеДанные);
КонецФункции
&НаКлиенте
Функция сбисРазложитьСтрокуВМассивПодстрок(Знач Стр, Разделитель = ",")
	МассивСтрок = Новый Массив();
	ДлинаРазделителя = СтрДлина(Разделитель);
	Пока 1=1 Цикл
		Поз = Найти(Стр,Разделитель);
		Если Поз=0 Тогда
			МассивСтрок.Добавить(Стр);
			Возврат МассивСтрок;
		КонецЕсли;
		МассивСтрок.Добавить(Лев(Стр,Поз-1));
		Стр = Сред(Стр,Поз+ДлинаРазделителя);
	КонецЦикла;
КонецФункции
&НаКлиенте
Процедура УстановитьВидимостьОбновитьСтатусы(Кэш) Экспорт
	// Если более часа не проверяли статусы, то выводим красное предупреждение	
	Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.УстановитьВидимостьОбновитьСтатусы(Кэш);
КонецПроцедуры
&НаКлиенте
Функция сбисПодписант(Кэш, ИНН) Экспорт
	// Получает Информацию о подписанте документа
	СписокСертификатов = ПолучитьСписокСертификатов(Кэш, Новый Структура("ИНН",ИНН));
	Если СписокСертификатов.Количество()>0 Тогда
		Возврат СписокСертификатов[0].Значение;
	Иначе
		Возврат Новый Структура("Должность,ФИО,ИНН");
	КонецЕсли;
КонецФункции
&НаКлиенте
Функция сбисИдентификаторУчастника(Кэш, ИНН, КПП, Название) Экспорт
	// Получает Информацию о контрагенте с онлайна
	Участник = Новый Структура;
	Если СтрДлина(СокрЛП(Инн))=12 Тогда
		СвФЛ = Новый Структура;
		Участник.Вставить("СвФЛ",СвФЛ);
		Участник.СвФЛ.Вставить("ИНН",Инн);
		ФИОСтруктура = Кэш.ОбщиеФункции.сбисПолучитьФИОИзНазвания(Название);
		Участник.СвФЛ.Вставить("Фамилия",ФИОСтруктура.Фамилия);
		Участник.СвФЛ.Вставить("Имя",ФИОСтруктура.Имя);
		Участник.СвФЛ.Вставить("Отчество",ФИОСтруктура.Отчество);
	Иначе
		СвЮЛ = Новый Структура;
		Участник.Вставить("СвЮЛ",СвЮЛ);
		Участник.СвЮЛ.Вставить("ИНН",ИНН);
		Участник.СвЮЛ.Вставить("КПП",КПП);
		Участник.СвЮЛ.Вставить("Название",Название);
	КонецЕсли;
	оКонтрагент = ПолучитьИнформациюОКонтрагенте(Кэш, Участник);
	Если оКонтрагент<>Ложь Тогда
		Возврат оКонтрагент.Идентификатор;
	КонецЕсли;
	Возврат "";
КонецФункции

////////////////////////////////////////////////////
//////////////Серверные настройки вызов/////////////
////////////////////////////////////////////////////

&НаКлиенте
Функция ДоступныСерверныеНастройки() Экспорт
	Возврат Истина;
КонецФункции	

&НаКлиенте
Функция ПолучитьXslt(Кэш, ПараметрыСообщения, ДопПараметрыЗапроса, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.ПолучитьXslt(Кэш,ПараметрыСообщения,ДопПараметрыЗапроса,Отказ);
КонецФункции

&НаКлиенте
Функция ПолучитьИни(Кэш, ИмяМетода, ПараметрыСообщения, ДопПараметрыЗапроса, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.ПолучитьИни(Кэш, ИмяМетода, ПараметрыСообщения, ДопПараметрыЗапроса, Отказ);
КонецФункции

&НаКлиенте
Функция ЗаписатьConnection(Кэш, ПараметрыСообщения, ДопПараметрыЗапроса, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.ЗаписатьConnection(Кэш,ПараметрыСообщения,ДопПараметрыЗапроса,Отказ);
КонецФункции

&НаКлиенте
Функция ПолучитьСписокConnection(Кэш, ПараметрыСообщения, ДопПараметрыЗапроса, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.ПолучитьСписокConnection(Кэш,ПараметрыСообщения,ДопПараметрыЗапроса,Отказ);
КонецФункции

&НаКлиенте
Функция ПолучитьСписокConfig(Кэш, ПараметрыСообщения, ДополнительныеПараметры, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.ПолучитьСписокConfig(Кэш,ПараметрыСообщения,ДополнительныеПараметры,Отказ);
КонецФункции

////////////////////////////////////////////////////
//////////////////Статистика вызов//////////////////
////////////////////////////////////////////////////

&НаКлиенте
Функция сбисОтправитьСообщениеСтатистики(Кэш, СообщениеСтатистики, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.сбисОтправитьСообщениеСтатистики(Кэш,СообщениеСтатистики,Отказ);
КонецФункции

&НаКлиенте
Функция сбисОтправитьСообщениеОшибки(Кэш, СообщениеОбОшибке, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.сбисОтправитьСообщениеОшибки(Кэш,СообщениеОбОшибке,Отказ);
КонецФункции

&НаКлиенте
Функция сбисПроверкаОбновления(Кэш, ИнформацияОТекущейВерсии, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.сбисПроверкаОбновления(Кэш, ИнформацияОТекущейВерсии, Отказ);
КонецФункции

////////////////////////////////////////////////////
//////////////////Автообновление////////////////////
////////////////////////////////////////////////////

&НаКлиенте
Функция сбисПолучитьПараметрыАктуальнойВерсии(Кэш, ПараметрыОбновления, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.сбисПолучитьПараметрыАктуальнойВерсии(Кэш, ПараметрыОбновления, Отказ);
КонецФункции

&НаКлиенте
Функция сбисСохранитьВФайлПоСсылке(Кэш, сбисПараметрыФайла, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.сбисСохранитьВФайлПоСсылке(Кэш, сбисПараметрыФайла, Отказ);
КонецФункции

&НаКлиенте
Функция сбисВключенРезервныйДомен(Кэш, АдресСервера) Экспорт
	Возврат Ложь;
КонецФункции

////////////////////////////////////////////////////
//////////////Сотрудники////////////////////////////
////////////////////////////////////////////////////

&НаКлиенте
функция сбисЗаписатьСотрудников(Кэш, ДанныеСотрудников, Отказ) Экспорт
	// функция активирует серверные сертификаты для определенного списка ИНН	
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.сбисЗаписатьСотрудников(Кэш, ДанныеСотрудников, Отказ);
КонецФункции

////////////////////////////////////////////////////
//////////////////////Отправка//////////////////////
////////////////////////////////////////////////////

&НаКлиенте
Функция ОтправитьПакетыДокументов(Кэш, МассивПакетов, РезультатОтправки=Неопределено) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.ОтправитьПакетыДокументов(Кэш, МассивПакетов, РезультатОтправки);
КонецФункции

&НаКлиенте
Процедура СбисПолучитьОтветыПоОтправке(Кэш) Экспорт
	Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.СбисПолучитьОтветыПоОтправке(Кэш);
КонецПроцедуры

&НаКлиенте
Функция Отправка_ПодготовитьСтруктуруПакета(Кэш, ПараметрыВыполнить, ДополнительныеПараметры, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.Отправка_ПодготовитьСтруктуруПакета(Кэш, ПараметрыВыполнить, Новый Структура("Шифрование", Истина), Отказ);
КонецФункции

&НаКлиенте
Процедура Отправка_Вызов(Кэш, ПараметрыОтправки, ДопПараметры) Экспорт
	Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.Отправка_Вызов(Кэш, ПараметрыОтправки, ДопПараметры);
КонецПроцедуры

////////////Обертки///////////////

&НаКлиенте
Функция СБИСПлагин_ИнформацияОСлужебныхЭтапах(Кэш, param, ДопПараметры, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.СБИСПлагин_ИнформацияОСлужебныхЭтапах(Кэш, param, ДопПараметры, Отказ);
КонецФункции

//Обработка внешнего файла. Пока в двоичных данных.
&НаКлиенте
Процедура СБИСПлагин_ОбработатьВнешнийФайл(Кэш, ПараметрыВложения, ПараметрыПодготовки) Экспорт
	ПараметрыВложения.Файл.Вставить("ДвоичныеДанные", сбисФайлСКлиентаВBASE64(ПараметрыВложения.Вложение.ПолноеИмяФайла));
КонецПроцедуры

&НаКлиенте
Процедура СБИСПлагин_ОбработатьXMLФайл(Кэш, ДанныеФайла, ПараметрыПодготовки) Экспорт
	Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.СБИСПлагин_ОбработатьXMLФайл(Кэш, ДанныеФайла, ПараметрыПодготовки);
КонецПроцедуры
	
&НаКлиенте
Функция СБИСПлагин_ПрочитатьДокумент(Кэш, param, ДопПараметры, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.СБИСПлагин_ПрочитатьДокумент(Кэш, param, ДопПараметры, Отказ);
КонецФункции

&НаКлиенте
Функция СБИСПлагин_ПрочитатьДокументКакHTML(Кэш, param, ДопПараметры, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.СБИСПлагин_ПрочитатьДокументКакHTML(Кэш, param, ДопПараметры, Отказ);
КонецФункции	

&НаКлиенте
Функция СБИСПлагин_ИмпортНоменклатурыИзCML(Кэш, param, ДопПараметры, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.СБИСПлагин_ИмпортНоменклатурыИзCML(Кэш, param, ДопПараметры, Отказ);
КонецФункции

&НаКлиенте
Функция СБИСПлагин_РасшифроватьФайл(Кэш, param, ДопПараметры, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.СБИСПлагин_РасшифроватьФайл(Кэш, param, ДопПараметры, Отказ);
КонецФункции

&НаКлиенте
Функция СБИСПлагин_ВыполнитьДействие(Кэш, document_in, ДопПараметры, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.СБИСПлагин_ВыполнитьДействие(Кэш, document_in, ДопПараметры, Отказ);
КонецФункции

&НаКлиенте
Функция СБИСПлагин_ЗаписатьСотрудника(Кэш, param, ДопПараметры, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.СБИСПлагин_ЗаписатьСотрудника(Кэш, param, ДопПараметры, Отказ);
КонецФункции

&НаКлиенте
Функция СБИСПлагин_ОбработкаСлужебныхЭтапов(Кэш, param, ДопПараметры, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.СБИСПлагин_ОбработкаСлужебныхЭтапов(Кэш, param, ДопПараметры, Отказ);
КонецФункции
	
&НаКлиенте
Функция СБИСПлагин_СписокДокументов(Кэш, filter, ДопПараметры, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.СБИСПлагин_СписокДокументов(Кэш, filter, ДопПараметры, Отказ);
КонецФункции

&НаКлиенте
Функция СБИСПлагин_СписокИзменений(Кэш, filter, ДопПараметры, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.СБИСПлагин_СписокИзменений(Кэш, filter, ДопПараметры, Отказ);
КонецФункции

&НаКлиенте
Функция СБИСПлагин_СписокНашихОрганизаций(Кэш, filter, ДопПараметры, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.СБИСПлагин_СписокНашихОрганизаций(Кэш, filter, ДопПараметры, Отказ);
КонецФункции

&НаКлиенте
Функция СБИСПлагин_СписокДокументовПоСобытиям(Кэш, filter, ДопПараметры, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.СБИСПлагин_СписокДокументовПоСобытиям(Кэш, filter, ДопПараметры, Отказ);
КонецФункции

#Область include_core_vo2_СпособыОбмена_ExtSDKCrypto_1_ВнешниеОбертки

&НаКлиенте
Функция СБИС_ВыполнитьДействие(Кэш, document_in, ДопПараметры, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.СБИС_ВыполнитьДействие(Кэш, document_in, ДопПараметры, Отказ);
КонецФункции

&НаКлиенте
Функция СБИС_ПодготовитьДействие(Кэш, document_in, ДопПараметры, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.СБИС_ПодготовитьДействие(Кэш, document_in, ДопПараметры, Отказ);
КонецФункции	

&НаКлиенте
Функция СБИС_СериализоватьСтрокуВBase64(Кэш, ПараметрыСериализовать, ДопПараметры, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.СБИС_СериализоватьСтрокуВBase64(Кэш, ПараметрыСериализовать, ДопПараметры, Отказ);
КонецФункции

&НаКлиенте
Функция СБИС_СохранитьПоСсылкеВФайл(Кэш, ПараметрыФайла, ДопПараметры, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.СБИС_СохранитьПоСсылкеВФайл(Кэш, ПараметрыФайла, ДопПараметры, Отказ);
КонецФункции

&НаКлиенте
Функция СБИС_СписокИзменений(Кэш, filter, ДопПараметры, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.СБИС_СписокИзменений(Кэш, filter, ДопПараметры, Отказ);
КонецФункции

&НаКлиенте
Функция СБИС_ТекущаяДата(Кэш, Отказ=Ложь) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.СБИС_ТекущаяДата(Кэш, Отказ);
КонецФункции	
	
&НаКлиенте
Функция СБИС_ИнформацияОКонтрагенте(Кэш, СтруктураКонтрагента, ДопПараметры, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK(Кэш, СтруктураКонтрагента, ДопПараметры, Отказ)
КонецФункции

&НаКлиенте
Функция СБИС_ПолучитьИнформациюОТекущемПользователе(Кэш, param, ДопПараметры, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.СБИС_ПолучитьИнформациюОТекущемПользователе(Кэш, param, ДопПараметры, Отказ);
КонецФункции    

&НаКлиенте
Функция СБИС_ПолучитьСписокАккаунтов(Кэш, param, ДопПараметры, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.СБИС_ПолучитьСписокАккаунтов(Кэш, param, ДопПараметры, Отказ);
КонецФункции

&НаКлиенте
Функция СБИС_ПереключитьАккаунт(Кэш, param, ДопПараметры, Отказ) Экспорт
	Возврат Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.СБИС_ПереключитьАккаунт(Кэш, param, ДопПараметры, Отказ);
КонецФункции

&НаКлиенте
Функция СБИС_ПолучитьПараметрыПакетаДляОткрытияОнлайн(ОписаниеПакета, ДопПараметры) Экспорт
	Возврат ДопПараметры.Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.СБИС_ПолучитьПараметрыПакетаДляОткрытияОнлайн(ОписаниеПакета, ДопПараметры);
КонецФункции

&НаКлиенте
Функция АПИ3_ИнитКоннекшен(ПараметрыИнит, ДопПараметрыВызова) Экспорт
	Возврат ДопПараметрыВызова.Кэш.СБИС.ДанныеИнтеграции.Объекты.Форма_ExtSDK.АПИ3_ИнитКоннекшен(ПараметрыИнит, ДопПараметрыВызова);
КонецФункции

#КонецОбласти

