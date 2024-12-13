Перем ОсновнойМодуль Экспорт;
перем кэшОбщиеМетоды, ОбщиеМетодыУпорядоченные;
перем ПеременныеМодуля;
перем ОтносительныйКаталогСценариев;

//{ работа с файловой системой, распаковка архива сценариев

Функция КаталогРепозитория()
	
	Ф1 = Новый Файл(ЭтотОбъект.ИспользуемоеИмяФайла);
	Ф2 = Новый Файл(Ф1.Путь + "..\");
	Возврат Ф2.ПолноеИмя + "\";
	
КонецФункции

Функция МодульНаходитсяВРепозитории()
	
	// проверить используемое имя файла
	Ф = Новый Файл(КаталогРепозитория() + "\bricks\");
	Результат = Ф.Существует() И Ф.ЭтоКаталог();
	Возврат Результат;
	
КонецФункции	

Функция РаспаковатьСценарии() Экспорт

	Результат = Новый ТаблицаЗначений;
	Результат.Колонки.Добавить("Путь");
	Результат.Колонки.Добавить("Имя");
	Результат.Колонки.Добавить("РаспакованныйФайл");
	
	Если МодульНаходитсяВРепозитории() Тогда
		
		ЗаполнитьТаблицуСценариевИзКаталога(Результат, КорневойКаталогСценариев() + ОтносительныйКаталогСценариев);
		Возврат Результат;
		
	КонецЕсли;
	
	// Если обработка находится не в репозитории, то надо извлечь из нее сценарии в temp
	ИмяВремФайла = ПолучитьИмяВременногоФайла(".zip");
	
	ИмяВремКаталога = ИмяВремКаталогаСценариев();
	ПересоздатьКаталог(ИмяВремКаталога);
	
	ПолучитьМакет("Сценарии_zip").Записать(ИмяВремФайла);
	ЧтениеЗип = Новый ЧтениеZipФайла(ИмяВремФайла);
	
	// 1. Файл корневого шаблона извлекаем как есть
	ФайлКорневогоШаблонаВАрхиве = ЧтениеЗип.Элементы.Найти("КорневойШаблон.txt");
	ЧтениеЗип.Извлечь(ФайлКорневогоШаблонаВАрхиве, ИмяВремКаталога);
	
	// 2. файлы из каталога ОбщиеМетоды распаковать отдельно
	РаспаковатьОбщиеМетоды(ЧтениеЗип, ИмяВремКаталога, "ОбщиеМетоды");
		
	// 3. Теперь извлечем сами сценарии, и получим таблицу с маппингом
	ЗаполнитьТаблицуСценариевИзАрхива(Результат, ЧтениеЗип);
	
	УдалитьФайлы(ИмяВремФайла);
	
	Возврат Результат;
	
КонецФункции

Процедура РаспаковатьОбщиеМетоды(ЧтениеЗип, ИмяВремКаталога, ТипМетодов)
	
	ПапкаСМетодами = "bricks\" + ТипМетодов + "\";
	
	СоздатьКаталог(ИмяВремКаталога + ПапкаСМетодами);
	
	Для Каждого Эл Из ЧтениеЗип.Элементы Цикл
		
		ПутьФайлаВАрхиве = СтрЗаменить(Эл.Путь, "/", "\");  // на старых платформах
		
		Если нрег(ПутьФайлаВАрхиве) = нрег(ПапкаСМетодами) Тогда
			ЧтениеЗип.Извлечь(Эл, ИмяВремКаталога);
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

Процедура ЗаполнитьТаблицуСценариевИзАрхива(ТаблицаСценариев, ЧтениеZip)
	
	ДлинаПодстроки = СтрДлина(ОтносительныйКаталогСценариев);
	
	Для Каждого Эл Из ЧтениеZip.Элементы Цикл
		
		ПутьФайлаВАрхиве = СтрЗаменить(Эл.Путь, "/", "\");  // на старых платформах
		Если ЗначениеЗаполнено(Эл.Имя)
			И нрег(Лев(ПутьФайлаВАрхиве, ДлинаПодстроки)) = нрег(ОтносительныйКаталогСценариев) Тогда
			
			НовСтр = ТаблицаСценариев.Добавить();
			НовСтр.Путь = Сред(ПутьФайлаВАрхиве, ДлинаПодстроки + 1);
			НовСтр.Имя = Эл.ИмяБезРасширения;
			
			// Распакуем на диск
			Гуид = Строка(Новый УникальныйИдентификатор);
			ПутьНаДиске = ИмяВремКаталогаСценариев() + ОтносительныйКаталогСценариев + Гуид;
			ЧтениеZip.Извлечь(Эл, ПутьнаДиске, РежимВосстановленияПутейФайловZIP.НеВосстанавливать);
			НовСтр.РаспакованныйФайл = ПутьнаДиске + "\" + Эл.Имя;
			
		КонецЕсли;	
		
	КонецЦикла;	
	
КонецПроцедуры

Процедура ЗаполнитьТаблицуСценариевИзКаталога(ТаблицаСценариев, Каталог)
	
	ДлинаПодстроки = СтрДлина(Каталог);
	
	Файлы = НайтиФайлы(Каталог, "*", Истина);
	
	Для Каждого Файл Из Файлы Цикл
		
		Если ЗначениеЗаполнено(Файл.Имя)
			И нрег(Лев(Файл.Путь, ДлинаПодстроки)) = нрег(Каталог)
			И Файл.ЭтоФайл() Тогда
			
			НовСтр = ТаблицаСценариев.Добавить();
			НовСтр.Путь = Сред(Файл.Путь, ДлинаПодстроки + 1);
			НовСтр.Имя = Файл.ИмяБезРасширения;
			
			НовСтр.РаспакованныйФайл = Файл.ПолноеИмя;
			
		КонецЕсли;	
		
	КонецЦикла;	
	
КонецПроцедуры

Процедура ПересоздатьКаталог(ЗНАЧ Каталог) Экспорт
	
	Ф = Новый Файл(Каталог);
	
	Если Ф.Существует() Тогда
		УдалитьФайлы(Каталог);
	КонецЕсли;
	
	СоздатьКаталог(Каталог);
	
КонецПроцедуры	

Функция ИмяВремКаталогаСценариев()
	
	Возврат КаталогВременныхФайлов() + "\Diadoc_ГенераторПМСценарии\";
	
КонецФункции

Функция КорневойКаталогСценариев() Экспорт
	
	Если МодульНаходитсяВРепозитории() Тогда
		Возврат КаталогРепозитория();
	Иначе
		Возврат ИмяВремКаталогаСценариев();
	КонецЕсли;	
	
КонецФункции

Функция ФайлКорневогоШаблона() Экспорт
	
	Возврат КорневойКаталогСценариев() + "\bricks\КорневойШаблон.txt";

КонецФункции	

//} работа с файловой системой, распаковка архива сценариев


Функция ГенерироватьТекстПодключаемогоМодуля(ФайлыВыбранныхШаблонов) Экспорт
	
	Результат = Новый ТекстовыйДокумент;
	
	ФайлКорневогоШаблона = ФайлКорневогоШаблона();
	
	кэшОбщиеМетоды.Очистить();
	ОбщиеМетодыУпорядоченные.Очистить();
	
	ПеременныеМодуля.Очистить();
	
	КорневойШаблон = ТекстовыйДокументИзФайлаUtf8(ФайлКорневогоШаблона);

	ТекстКорневогоШаблона = КорневойШаблон.ПолучитьТекст();
	
	СтруктурыШаблонов = Новый Массив;
	Для каждого ИмяФайла Из ФайлыВыбранныхШаблонов Цикл
		СтруктурыШаблонов.Добавить(СтруктураФайлаШаблона(ИмяФайла));  // парсим шаблоны
	КонецЦикла;
	
	ТекстПеременныхМодуля = ТекстПеременныхМодуля();
	
	ТекстФункцииОбработатьСобытие = ТекстФункцииОбработатьСобытие(СтруктурыШаблонов);
	
	ТекстОбработчиковСобытий	= ТекстОбработчиковСобытий(СтруктурыШаблонов);
	ТекстЛокальныхМетодов 		= ТекстЛокальныхМетодов(СтруктурыШаблонов);
	ТекстСлужебнойИнформации 	= ТекстСлужебнойИнформации(СтруктурыШаблонов);
	
	ТекстОбщихМетодов = ТекстОбщихМетодов(кэшОбщиеМетоды, ОбщиеМетодыУпорядоченные);
	
	ТекстКорневогоШаблона = СтрЗаменить(ТекстКорневогоШаблона, "//#ПеременныеМодуля",		ТекстПеременныхМодуля);
	ТекстКорневогоШаблона = СтрЗаменить(ТекстКорневогоШаблона, "//#ОбработатьСобытие",		ТекстФункцииОбработатьСобытие);
	ТекстКорневогоШаблона = СтрЗаменить(ТекстКорневогоШаблона, "//#ОбработчикиСобытий",		ТекстОбработчиковСобытий);
	ТекстКорневогоШаблона = СтрЗаменить(ТекстКорневогоШаблона, "//#ВспомогательныеМетоды",	ТекстЛокальныхМетодов);
	ТекстКорневогоШаблона = СтрЗаменить(ТекстКорневогоШаблона, "//#ОбщиеМетоды",			ТекстОбщихМетодов);
	ТекстКорневогоШаблона = СтрЗаменить(ТекстКорневогоШаблона, "//#СлужебнаяИнформация",	ТекстСлужебнойИнформации);
	
	Результат.УстановитьТекст(ТекстКорневогоШаблона);
	
	Возврат Результат;
	
КонецФункции

Функция СтруктураФайлаШаблона(ИмяФайла) Экспорт
	
	Результат = Новый Структура;
	Результат.Вставить("Описание", "");
	Результат.Вставить("ИмяФайла", "");
	Результат.Вставить("ОбработчикиСобытий", Новый Соответствие);
	Результат.Вставить("ПрочиеМетодыТекстом", "");
	
	Ф = Новый Файл(ИмяФайла);
	Результат.ИмяФайла = Ф.ИмяБезРасширения;
	
	ТД = ТекстовыйДокументИзФайлаUtf8(ИмяФайла);
	
	Область_Описание = СтрокиОбласти(ТД, "Описание", 1, 1);
	Результат.Описание = Область_Описание.ПолучитьТекст();
	
	Область_ОбработчикиСобытий = СтрокиОбласти(ТД, "ОбработчикиСобытий", 1, 1);
	Для Сч = 1 по Область_ОбработчикиСобытий.КоличествоСтрок() Цикл
		
		ИмяОбработчика = Область_ОбработчикиСобытий.ПолучитьСтроку(Сч);
		ТекстОбработчика = СтрокиОбласти(ТД, "ОбработчикСобытия_" + ИмяОбработчика,  2, 2); // отрезаем начало и конец метода: Функция...КонецФункции
		ТекстОбработчика = СокрЛП_ТекстовыйДокумент(ТекстОбработчика);
		
		Результат.ОбработчикиСобытий.Вставить(ИмяОбработчика, ТекстОбработчика);
		
	КонецЦикла;	
	
	Область_ЛокальныеМетоды = СтрокиОбласти(ТД, "ВспомогательныеМетоды", 1, 1);
	Область_ЛокальныеМетоды = СокрЛП_ТекстовыйДокумент(Область_ЛокальныеМетоды);
	Результат.ПрочиеМетодыТекстом = Область_ЛокальныеМетоды.ПолучитьТекст();
	
	ЗаполнитьПеременныеМодуля(ТД);
	
	ЗаполнитьОбщиеМетоды(ТД, "ОбщиеМетоды", кэшОбщиеМетоды, ОбщиеМетодыУпорядоченные);
	
	Возврат Результат;
	
КонецФункции

Процедура ЗаполнитьПеременныеМодуля(ТД)

	Область_ПеременныеМодуля = СтрокиОбласти(ТД, "ПеременныеМодуля", 1, 1);
	
	Для Сч = 1 по Область_ПеременныеМодуля.КоличествоСтрок() Цикл
		
	 	ИмяПеременной = Область_ПеременныеМодуля.ПолучитьСтроку(Сч);
		
		Если ПеременныеМодуля.Найти(ИмяПеременной) <> Неопределено Тогда
			Продолжить;
		КонецЕсли;
		
		ПеременныеМодуля.Добавить(ИмяПеременной);
		
	КонецЦикла;	
	
КонецПроцедуры

Процедура ЗаполнитьОбщиеМетоды(ТД, ТипМетодов, кэшМетодов, МетодыУпорядоченные)
	
	Область_ОбщиеМетоды = СтрокиОбласти(ТД, ТипМетодов, 1, 1);
	
	Для Сч = 1 по Область_ОбщиеМетоды.КоличествоСтрок() Цикл
		
		ИмяОбщегоМетода = Область_ОбщиеМетоды.ПолучитьСтроку(Сч);
		
		Если кэшМетодов.Получить(ИмяОбщегоМетода) <> Неопределено Тогда
			Продолжить;
		КонецЕсли;
		
		ТекстОбщегоМетода = ТекстОбщегоМетода(ТипМетодов, ИмяОбщегоМетода);
		
		ТекстОбщегоМетода = СокрЛП_ТекстовыйДокумент(ТекстОбщегоМетода);
		
		кэшМетодов.Вставить(ИмяОбщегоМетода, ТекстОбщегоМетода);
		
		МетодыУпорядоченные.Добавить(ИмяОбщегоМетода);
		
	КонецЦикла;	
	
КонецПроцедуры

Функция ТекстПеременныхМодуля()
	
	Результат = "";
	
	Если ПеременныеМодуля.Количество() = 0 Тогда
		Возврат Результат;
	КонецЕсли;
	
	Разделитель = "";
	
	Для Каждого ИмяПеременной Из ПеременныеМодуля Цикл
		
		Результат = Результат + Разделитель + ИмяПеременной;
		
		Разделитель = ", ";
		
	КонецЦикла;
	
	Результат = "Перем " + Результат + ";";
	
	Возврат Результат;
	
КонецФункции

Функция ТекстОбщегоМетода(ПапкаОбщегоМетода, ИмяОбщегоМетода)

	ПутьКФайлуОбщегоМетода = КорневойКаталогСценариев() + "\bricks\" + ПапкаОбщегоМетода + "\" + ИмяОбщегоМетода + ".txt";
	
	Возврат ТекстовыйДокументИзФайлаUtf8(ПутьКФайлуОбщегоМетода);

КонецФункции

Функция ПолучитьМассивИспользуемыхОбработчиков(СтруктурыШаблонов)
	
	Результат = Новый Массив;
	
	Для Каждого СтруктураФайла Из СтруктурыШаблонов Цикл
		
		Для Каждого ОписаниеОбработчика Из СтруктураФайла.ОбработчикиСобытий Цикл
			Если Результат.Найти(ОписаниеОбработчика.Ключ) = Неопределено Тогда
				Результат.Добавить(ОписаниеОбработчика.Ключ);
			КонецЕсли;	
		КонецЦикла;
		
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции	

Функция ТекстФункцииОбработатьСобытие(СтруктурыШаблонов)
	
	Результат = "";
	
	Обработчики = ПолучитьМассивИспользуемыхОбработчиков(СтруктурыШаблонов);
	
	Если Обработчики.Количество() = 0 Тогда
		Возврат Результат;
	КонецЕсли;	
	
	Результат = "";
	
	Шаблон_Начало = 
	"	Если ИмяСобытия = ""%1"" Тогда
	|
	|		Возврат %1(Параметры);
	|
	|";	
	
	Шаблон_Середина = 
	"	ИначеЕсли ИмяСобытия = ""%1"" Тогда
	|
	|		Возврат %1(Параметры);
	|
	|";
	
	Шаблон_Конец = 
	"	КонецЕсли;";
	
	
	Для Каждого ИмяОбработчика Из Обработчики Цикл
		
		Если Результат = "" Тогда
			Результат = ПодставитьВСтроку(Шаблон_Начало, ИмяОбработчика);
		Иначе	
			Результат = Результат + ПодставитьВСтроку(Шаблон_Середина, ИмяОбработчика);
		КонецЕсли;	
		
	КонецЦикла;	
	
	Результат = Результат + Шаблон_Конец;
	
	Возврат Результат;
	
КонецФункции

Функция ТекстСлужебнойИнформации(СтруктурыШаблонов)
	
	Результат = 
	"	// ВерсияПостроителя: %1
	|	//{ Сценарии
	|";
	
	Результат = ПодставитьВСтроку(Результат, ВерсияОбработки());
	
	Шаблон_СтрокаСценария = 
	"	// %1
	|";
	
	Для Каждого ОписаниеШаблона Из СтруктурыШаблонов Цикл
		Результат = Результат + ПодставитьВСтроку(Шаблон_СтрокаСценария, ОписаниеШаблона.ИмяФайла);
	КонецЦикла;	
	
	Результат = Результат + 
	"	//} Сценарии
	|";
	
	Возврат Результат;
	
КонецФункции

Функция ТекстОбработчиковСобытий(СтруктурыШаблонов)
	
	Результат = "";
	
	ШаблонМетода = 
	"Функция %1(Параметры)
	|
	|%2
	|
	|КонецФункции
	|";
	
	
	// точно будет 2 цикла. Один добавляет обработчики, второй - мержит внутри обработчиков.
	// а перед этим надо еще пройтись по всем обработчикам и собрать в кучу
	Обработчики = ПолучитьМассивИспользуемыхОбработчиков(СтруктурыШаблонов);
	Для Каждого ИмяОбработчика Из Обработчики Цикл
		
		СодержимоеТекущегоОбработчика = "";
		
		Для Каждого СтруктураФайла Из СтруктурыШаблонов Цикл
			
			Для Каждого ОписаниеОбработчика Из СтруктураФайла.ОбработчикиСобытий Цикл
				
				Если ОписаниеОбработчика.Ключ = ИмяОбработчика Тогда
					  		
					Если Не ПустаяСтрока(СодержимоеТекущегоОбработчика) Тогда
						СодержимоеТекущегоОбработчика = СодержимоеТекущегоОбработчика + Символы.ПС + Символы.ПС;
					КонецЕсли;
					
					СодержимоеТекущегоОбработчика = СодержимоеТекущегоОбработчика
													+ "	// Имя шаблона: "  + СтруктураФайла.ИмяФайла + Символы.ПС
													+ СокрП(ОписаниеОбработчика.Значение.ПолучитьТекст());
													
				КонецЕсли;
				
			КонецЦикла;
			
		КонецЦикла;
		
		Если Не ПустаяСтрока(Результат) Тогда
			Результат = Результат + Символы.ПС;
		КонецЕсли;
					
		Результат = Результат + ПодставитьВСтроку(ШаблонМетода, ИмяОбработчика, СодержимоеТекущегоОбработчика);
		
	КонецЦикла;
		
	Возврат Результат;
	
КонецФункции

Функция ТекстЛокальныхМетодов(СтруктурыШаблонов)
	
	Результат = "";
	
	Для Каждого СтруктураФайла Из СтруктурыШаблонов Цикл
			
		Если Не ПустаяСтрока(Результат) Тогда
			Результат = Результат + Символы.ПС;
		КонецЕсли;
			
		Результат = Результат + СтруктураФайла.ПрочиеМетодыТекстом;
		
	КонецЦикла;
		
	Возврат Результат;
	
КонецФункции

Функция ТекстОбщихМетодов(кэшМетодов, МетодыУпорядоченные)
	
	Результат = "";
	
	Разделитель = "";
	
	Для Каждого ОбщийМетод Из МетодыУпорядоченные Цикл
		
		ОписаниеОбщегоМетода = кэшМетодов.Получить(ОбщийМетод);
		
		Результат = Результат + Разделитель + ОписаниеОбщегоМетода.ПолучитьТекст();
	
		Разделитель = Символы.ПС;
	
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

Функция ТекстовыйДокументИзФайлаUtf8(ИмяФайла) Экспорт
	
	Результат = Новый ТекстовыйДокумент;
	Результат.Прочитать(ИмяФайла, КодировкаТекста.UTF8);
	Возврат Результат;
	
КонецФункции	

Функция ПодставитьВСтроку(ЗНАЧ Стр, п1 = "", п2 = "", п3 = "", п4 = "", п5 = "")
	
	Стр = СтрЗаменить(Стр, "%1", п1);
	Стр = СтрЗаменить(Стр, "%2", п2);
	Стр = СтрЗаменить(Стр, "%3", п3);
	Стр = СтрЗаменить(Стр, "%4", п4);
	Стр = СтрЗаменить(Стр, "%5", п5);
	
	Возврат Стр;
	
КонецФункции	

// УдалитьПервыеСтроки = 0, если надо с самого начала
// УдалитьПоследниеСтроки = 0, если надо до конца
// УдалитьПоследниеСтроки = 1, если надо исключить последнюю строку
// нужно для того, чтобы исключить само объявление области из текста
Функция СтрокиОбласти(ТекстовыйДокумент, ИмяОбласти, УдалитьПервыеСтроки, УдалитьПоследниеСтроки)
	
	Результат = Новый ТекстовыйДокумент;
	
	Область = ТекстовыйДокумент.ПолучитьОбласть(ИмяОбласти);
	Область = СокрЛП_ТекстовыйДокумент(Область);
	
	Для Сч = УдалитьПервыеСтроки + 1  По Область.КоличествоСтрок() - УдалитьПоследниеСтроки Цикл
		Результат.ДобавитьСтроку(Область.ПолучитьСтроку(Сч));
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции	

// Убирает первые и последние пустые строки в ТекстовыйДокумент
Функция СокрЛП_ТекстовыйДокумент(ТД)
	
	// найти первую строку, которая не пустая
	// и последнюю
	
	Результат = Новый ТекстовыйДокумент;
	
	Для НомерПервойНепустойСтроки = 1 По ТД.КоличествоСтрок()  Цикл
		
		Стр = ТД.ПолучитьСтроку(НомерПервойНепустойСтроки);
		Если СокрЛП(Стр) <> "" Тогда
			Прервать;
		КонецЕсли;	
		
	КонецЦикла;	
	
	НомерПоследнейНепустойСтроки = ТД.КоличествоСтрок();
	
	Для Сч = 1 По ТД.КоличествоСтрок()  Цикл
		
		Стр = ТД.ПолучитьСтроку(НомерПоследнейНепустойСтроки);
		Если СокрЛП(Стр) <> "" Тогда
			Прервать;
		КонецЕсли;	
		
		НомерПоследнейНепустойСтроки = НомерПоследнейНепустойСтроки - 1;
		
	КонецЦикла;
	
	Для Сч = НомерПервойНепустойСтроки По НомерПоследнейНепустойСтроки цикл
		Результат.ДобавитьСтроку(ТД.ПолучитьСтроку(Сч));
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции	


// Разделяет строку на части по указанным символам-разделителям.
// По аналогии с глобальным методом СтрРазделить, добавленным в платформу версии 8.3.6.
//
// Параметры:
//  Строка         - Строка - разделяемая строка;
//  Разделитель    - Строка - строка символов, каждый из которых является индивидуальным разделителем;
//  ВключатьПустые - Булево - Ложь, если пустые части строки включать в результат не нужно.
// 
// Возвращаемое значение:
//   Массив - массив со строками, которые получились в результате разделения исходной строки.
//
Функция РазделитьСтроку(Знач Строка, Разделитель = ",", ВключатьПустые = Истина) Экспорт
	
	Результат = Новый Массив;
	
	МассивРазделителей = Новый Массив;
	
	Для Сч = 1 По СтрДлина(Разделитель) Цикл
		СимволРазделителя = Сред(Разделитель, Сч, 1);
		МассивРазделителей.Добавить(СимволРазделителя);
	КонецЦикла;
	
	Пока Истина Цикл
		
		Поз = 0;
		
		Для Каждого СимволРазделителя Из МассивРазделителей Цикл
			
			Поз = Найти(Строка, СимволРазделителя);
			
			Если Поз > 0 Тогда
				Прервать;
			КонецЕсли;
			
		КонецЦикла;
		
		Если Поз = 0 Тогда
			Подстрока	 = СокрЛП(Строка);
			Строка		 = "";
		Иначе
			Подстрока	 = СокрЛП(Лев(Строка, Поз - 1));
			Строка		 = Сред(Строка, Поз + 1);
		КонецЕсли;
		
		Если ВключатьПустые ИЛИ ЗначениеЗаполнено(Подстрока) Тогда
			Результат.Добавить(Подстрока);
		КонецЕсли;
		
		Если Поз = 0 Тогда
			Прервать; // Нет разделителя, за которым могла бы быть следующая часть строки.
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции



//{ Общий код в формах

Процедура ДобавитьСценарииВДеревоИзТаблицы(ДеревоСценариев, ТаблицаСценариев) Экспорт
	
	Для Каждого Стр Из ТаблицаСценариев Цикл
		
		РодительскаяСтрока = СтрокаДереваСценариев(Стр.Путь, ДеревоСценариев);
		
		НовСценарий = РодительскаяСтрока.Строки.Добавить();
		НовСценарий.Название = Стр.Имя;  // без расширения сделать
		НовСценарий.ПутьКФайлу = Стр.РаспакованныйФайл;
		
	КонецЦикла;	
	
КонецПроцедуры

Функция СтрокаДереваСценариев(ЗНАЧ Путь, ДеревоСценариев)
	
	Результат = ДеревоСценариев;
	
	Если Прав(Путь, 1) = "\" Тогда
		Путь = Лев(Путь, СтрДлина(Путь) - 1);
	КонецЕсли;	
	
	Переходы = РазделитьСтроку(Путь, "\");
	Для Каждого Элемент Из Переходы Цикл
		
		СтрокаСценариев = Результат.Строки.Найти(Элемент, "Название", Ложь);
		Если СтрокаСценариев = Неопределено Тогда
			Результат = Результат.Строки.Добавить();
			Результат.Название = Элемент;
		Иначе
			Результат = СтрокаСценариев;
		КонецЕсли;
		
	КонецЦикла;	
	
	Возврат Результат;
	
КонецФункции

//} Общий код в формах



// Программный интерфейс плагинов

// Описание плагина
//
// Возвращаемое значение:
//  Структура - содержит поля:
//
//   * ИмяПлагина - Строка - имя обработки;
//   * Наименование - Строка - синоним обработки;
//
//   * Описание - Строка - краткое описание из макета;
//   * АдресСправки - Строка - полное описанием плагина в Контур.Справке;
//
//   * Расположение - Структура - см. Новый_РасположениеПлагина();
//
//   * Версия - Строка - версия плагина;
//   * ДатаПубликации - Дата - дата публикации в сервисе;
//
//   * Ошибки - Массив - содержит структуры, см. Новый_ОшибкаПлагина();
//   * События - Массив - содержит имена событий, которые плагин может обработать;
//
//   * Загружен - Булево - Истина, если файл плагина загружен в базу;
//   * Включен - Булево - Истина, если плагин используется;
//   * Рекомендован - Булево - Истина, если плагин рекомендован к использованию;
//   * Экспериментальный - Булево - Истина, если это бета-версия плагина;
//
Функция СведенияОВнешнейОбработке() Экспорт
	
	ПараметрыРегистрации = Новый Структура;
	
	ПараметрыРегистрации.Вставить("Вид",			 	"ДополнительнаяОбработка");
	ПараметрыРегистрации.Вставить("Наименование", 		Метаданные().Синоним);
	ПараметрыРегистрации.Вставить("БезопасныйРежим", 	Ложь);
	ПараметрыРегистрации.Вставить("Версия", 			ВерсияОбработки());
	ПараметрыРегистрации.Вставить("Информация", 		"Диадок: плагин для работы с Wildberries");
	
	ТаблицаКоманд = ПолучитьТаблицуКоманд();
	
	ПараметрыРегистрации.Вставить("Команды", ТаблицаКоманд);
	
	Возврат ПараметрыРегистрации;
	
КонецФункции

Функция ПолучитьТаблицуКоманд()
	
	Команды = Новый ТаблицаЗначений;
	
	Команды.Колонки.Добавить("Представление", 			Новый ОписаниеТипов("Строка")); 
	Команды.Колонки.Добавить("Идентификатор", 			Новый ОписаниеТипов("Строка"));
	Команды.Колонки.Добавить("Использование", 			Новый ОписаниеТипов("Строка"));
	Команды.Колонки.Добавить("ПоказыватьОповещение", 	Новый ОписаниеТипов("Булево"));
	Команды.Колонки.Добавить("Модификатор", 			Новый ОписаниеТипов("Строка"));
	
	Возврат Команды;
	
КонецФункции

// Возвращает версию плагина
//
// Возвращаемое значение:
//  Строка - версия плагина
//
Функция ВерсияОбработки() Экспорт
	
	Возврат "0.16.3";
	
КонецФункции	

// Возвращает минимальную версию основного модуля, с которым умеет работать данный плагин
//
// Возвращаемое значение:
//  Строка - версия основного модуля
//
Функция ВерсияОсновногоМодуля() Экспорт
	
	Возврат "4.8.30";
	
КонецФункции

Функция МанифестПлагина() Экспорт
	
	Результат = Новый Структура;
	
	Результат.Вставить("Идентификатор", 	Метаданные().Имя);
	Результат.Вставить("Представление", 	Метаданные().Синоним);
	Результат.Вставить("Проект",			"Diadoc");
	Результат.Вставить("Версия",			ВерсияОбработки());
	Результат.Вставить("Описание",			ПолучитьМакет("ОписаниеПлагина").ПолучитьТекст());
	Результат.Вставить("СсылкаНаСправку",	Метаданные().Комментарий);
	Результат.Вставить("События",			СобытияПлагина());
	Результат.Вставить("ЕстьНастройки",		Истина);
	Результат.Вставить("ПараметрыПроекта",	Неопределено); // для кастомных полей проектов?

	Возврат Результат;
	
КонецФункции

// Возвращает события, которые умеет обрабатывать плагин
//
// Возвращаемое значение:
//  Массив из Строка - элементы названия событий плагина
//
Функция СобытияПлагина() Экспорт
	
	Результат = Новый Массив;
	
//	Результат.Добавить("ПодготовитьЭлектронныйДокумент");
	
	Возврат Результат;
	
КонецФункции

Функция ПротестироватьПлагин() Экспорт
	
	Результат = Новый Структура;
	
	Результат.Вставить("Успешно",				Истина);
	Результат.Вставить("ТребуетсяНастройка",	Ложь);
	Результат.Вставить("ОписаниеОшибки",		"");
	
	Возврат Результат;	
	
КонецФункции

Функция ЭДО_ВерсияAPIПодключаемогоМодуля() Экспорт
	
	Возврат 3;
	
КонецФункции

Функция ОткрытьФормуНастроек(ВызывающийМодуль) Экспорт
	
	#Если ТолстыйКлиентОбычноеПриложение Тогда
		
		ФормаНастроек = ПолучитьФорму("Настройки_Обычная");
		ФормаНастроек.Инициализировать(ВызывающийМодуль);
		ФормаНастроек.ОткрытьМодально();
	
	#КонецЕсли

КонецФункции


// Программный интерфейс

кэшОбщиеМетоды = Новый Соответствие;

ОбщиеМетодыУпорядоченные = Новый Массив;

ПеременныеМодуля = Новый Массив;

ОтносительныйКаталогСценариев = "bricks\Сценарии\";