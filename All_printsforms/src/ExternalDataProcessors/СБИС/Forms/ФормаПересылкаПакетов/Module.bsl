
&НаКлиенте
Перем МестныйКэш Экспорт;
&НаКлиенте
Перем СписокДокументов Экспорт;
&НаКлиенте
Функция сбисЭлементФормы(Форма,ИмяЭлемента)
	Если ТипЗнч(ЭтаФорма) = Тип("УправляемаяФорма") Тогда
		Возврат Форма.Элементы.Найти(ИмяЭлемента);
	КонецЕсли;
	Возврат Форма.ЭлементыФормы.Найти(ИмяЭлемента);
КонецФункции
&НаКлиенте
Процедура сбисПоказатьСостояние(ТекстСостояния, Форма = Неопределено, Индикатор = Неопределено)
	Если ТипЗнч(ЭтаФорма) = Тип("УправляемаяФорма") Тогда
		Состояние(ТекстСостояния,Индикатор);
	Иначе
		Форма.ЭлементыФормы.ПанельОжидания.Видимость = Истина;
		Форма.НадписьОжидания = Символы.ПС + ТекстСостояния;
		Если Индикатор<>Неопределено Тогда
			Форма.ЭлементыФормы.Индикатор.Видимость = Истина;
			Форма.ЭлементыФормы.Индикатор.Значение = Индикатор;
		КонецЕсли;
	КонецЕсли;	
КонецПроцедуры

&НаКлиенте
Функция Показать(Кэш,СписокОтмеченныхДокументов)Экспорт
	МестныйКэш = Кэш;
	СписокДокументов = Новый СписокЗначений();
	//фрм = Кэш.ГлавноеОкно.сбисНайтиФормуФункции("ПолучитьВыборкуОтправляемыхПакетов",,"ФормаПересылкаПакетов",МестныйКэш);
	СписокДокументов = ПолучитьВыборкуОтправляемыхПакетов(МестныйКэш,СписокОтмеченныхДокументов);
	Если СписокДокументов.Количество()>0  Тогда
		Если Не ЭтаФорма.Открыта() Тогда
			ЭтаФорма.Открыть();
		КонецЕсли;	
	Иначе
		Сообщить("Переслать можно только утвержденные документы.");
	КонецЕсли;
КонецФункции	
&НаКлиенте
Функция ПолучитьВыборкуОтправляемыхПакетов(Кэш,СписокОтмеченныхДокументов)Экспорт
	СписокОтправляемыхДокументов = Новый СписокЗначений();
	Если СписокОтмеченныхДокументов.Количество()>0 Тогда
		Для Каждого Строка Из СписокОтмеченныхДокументов Цикл
			Если Строка.Значение.СоставПакета[0].Значение.Состояние.Код="7" Тогда //или Строка.Значение.СоставПакета[0].Значение.Состояние.Код="4" Тогда
				Строка.Значение.Отмечен = Истина;
				СписокОтправляемыхДокументов.Добавить(Строка.Значение);
			Иначе
				Строка.Значение.Отмечен = Ложь;
			КонецЕсли;	
		КонецЦикла;
	КонецЕсли;
	Возврат СписокОтправляемыхДокументов;
КонецФункции
&НаКлиенте
Процедура ПереслатьПакеты(Кнопка)
   	Если НЕ ЗначениеЗаполнено(Получатель) Тогда
		Сообщить("Не выбран получатель!");
		Возврат;
	КонецЕсли;	
	Если СписокДокументов.Количество()=0 Тогда
		Возврат;
	КонецЕсли;
	ВремКаталог = КаталогВременныхФайлов();
	ВремКаталог = ВремКаталог+"ПересылкаСБИС\";
	Каталог = Новый Файл(ВремКаталог);
	Если Не Каталог.Существует() Тогда
		СоздатьКаталог(ВремКаталог);
	КонецЕсли;
	ГлавноеОкно = МестныйКэш.ГлавноеОкно;

	МассивПакетов = Новый Массив;
	МассивФайловДляУдаления = Новый Массив;
	
	Всего =  СписокДокументов.Количество();
	сч=0;
	
	Для Каждого Строка из СписокДокументов Цикл
		Если Строка.Значение.Отмечен=Ложь Тогда
			Продолжить;
		КонецЕсли;
		сч=сч+1;
		
		сбисПоказатьСостояние("Формирование электронных документов",ГлавноеОкно,Мин(100,Окр(сч*100/Всего)));
		оДокумент = МестныйКэш.Интеграция.ПрочитатьДокумент(МестныйКэш,Строка.Значение.ИДСБИС);
		МассивВложений = СохранитьВложенияНаДиск(оДокумент);
		МассивПодписей = СохранитьПодписиНаДиск(оДокумент);
		Если МассивВложений.Количество()=0 Тогда
			Продолжить;
		КонецЕсли;
		
		СтруктураПакета = СформироватьСтруктуруПакетов(оДокумент,МассивВложений,МассивПодписей);
		МассивПакетов.Добавить(СтруктураПакета);
	КонецЦикла;	
	ВремяНачала = ТекущаяУниверсальнаяДатаВМиллисекундах();	
	РезультатОтправки = Новый Структура("ТипыОшибок,Отправлено,НеОтправлено,НеСформировано,Ошибок,ДетализацияОшибок,ВсегоПакетов,ОшибкиДоОтправки,ДанныеПоСтатусам,ПорНомер,КоличествоСвободныхПотоков,ОтправкаИзПересылки,ОтправленоСообщений,ПолученоОтветов,ВремяНачала,ВремяФормирования,ВремяОтправки,ДетализацияОтправки,ВремяЗаписиСтатусов,ВремяПолученияДанных,ВремяОжиданияОтвета, СформированныеПакеты", Новый СписокЗначений,0,0,0,0, Новый Соответствие,0,0,Новый Массив,0,30,Истина,0,0,ВремяНачала,0,0, Новый Соответствие,0,0,0, Новый Соответствие);
	РезультатОтправки.Вставить("НаЗаписьСтатусов", Новый Структура("Ошибки, Ответы", Новый Соответствие, Новый Соответствие));
	МестныйКэш.Вставить("РезультатОтправки",РезультатОтправки);
	МестныйКэш.ГлавноеОкно.сбисПолучитьФорму("Документ_Шаблон").ОтправитьПодготовленныеПакетыДокументы(МестныйКэш, МассивПакетов);
КонецПроцедуры
&НаКлиенте
Процедура ПослеОтправки(Кэш) Экспорт
// Если есть ошибки отправки, то выводим результат, иначе закрываем просмотр 	
	УдалитьСохраненныеВложения();
	Если ЭтаФорма.Открыта() Тогда
		ЭтаФорма.Закрыть();
	КонецЕсли;
КонецПроцедуры
&НаКлиенте
Процедура УдалитьСохраненныеВложения() Экспорт
	Попытка
		УдалитьФайлы(ВремКаталог);
	Исключение
		Ошибка=ОписаниеОшибки();
	КонецПопытки;
КонецПроцедуры
&НаКлиенте
Функция СформироватьСтруктуруПакетов(оДокумент,МассивВложений,МассивПодписей)Экспорт
	 СтруктураПакета = Новый Структура;
	 СтруктураПакета.Вставить("Вложение",Новый Массив);
	 СтруктураПакета.Вставить("НашаОрганизация", Новый Структура);
	 СтруктураПакета.Вставить("Контрагент", Новый Структура);
	 СтруктураПакета.Вставить("Тип","КоррИсх");
	 СтруктураПакета.Вставить("ДокументОснование",Новый Массив);
	 СтруктураПакета.Вставить("Дата",Формат(ТекущаяДата(),"ДЛФ=Д"));
	 ДокОснование = Новый Структура;
	 ДокОснование.Вставить("Идентификатор",оДокумент.Идентификатор);
	 ДокОснование.Вставить("ВидСвязи","Переслать");
	 СтруктураПакета.ДокументОснование.Добавить(ДокОснование);
	 ИНН="";
	 КПП=Неопределено;
	 //ищем ини для раздела "Продажа"
	 Для Каждого СтруктураИни из МестныйКэш.ини Цикл
		 Если Нрег(СтруктураИни.Ключ)="конфигурация" Тогда
			 Рекв_ИНН = СтруктураИни.Значение.Контрагенты_ИНН.Значение;
			 Рекв_КПП = СтруктураИни.Значение.Контрагенты_КПП.Значение; 
			 фрм = МестныйКэш.ГлавноеОкно.сбисПолучитьФорму("РаботаСДокументами1С");
			 ИНН = фрм.ПолучитьРеквизитОбъекта(Получатель,фрм.сбисСообщитьИмяРеквизита(Рекв_ИНН));
			 Если СтрДлина(СокрЛП(ИНН))=10 Тогда
				КПП = фрм.ПолучитьРеквизитОбъекта(Получатель,фрм.сбисСообщитьИмяРеквизита(Рекв_КПП));				 
			 КонецЕсли;
			
			 Прервать;
		 КонецЕсли;	 
	 КонецЦикла;	 
	 
	 Если КПП<>Неопределено Тогда
		 СтруктураПакета.Контрагент.Вставить("СвЮЛ",Новый Структура);
		 СтруктураПакета.Контрагент.СвЮЛ.Вставить("ИНН",ИНН);
		 СтруктураПакета.Контрагент.СвЮЛ.Вставить("КПП",КПП);
	 Иначе	 
		 СтруктураПакета.Контрагент.Вставить("СвФЛ",Новый Структура);
		 СтруктураПакета.Контрагент.СвФЛ.Вставить("ИНН",ИНН);
	 КонецЕсли;	 
	 
	 Если оДокумент.НашаОрганизация.Свойство("СвЮЛ") Тогда
		  СтруктураПакета.НашаОрганизация.Вставить("СвЮЛ",оДокумент.НашаОрганизация.СвЮЛ);
	 Иначе
		  СтруктураПакета.НашаОрганизация.Вставить("СвФЛ",оДокумент.НашаОрганизация.СвФЛ);
     КонецЕсли;
     сч = 0;
	 Для Каждого оФайл из МассивВложений Цикл
		НайденнаяПодпись = "";
		Подпись = Новый Массив;
		СтруктураВложения = Новый Структура;
		СтруктураВложения.Вставить("ИмяФайла",оФайл.Имя);
		СтруктураВложения.Вставить("ПолноеИмяФайла",оФайл.ПолноеИмя);
		СтруктураВложения.Вставить("Тип",оДокумент.Вложение[сч].Тип);
		СтруктураВложения.Вставить("ПодТип",оДокумент.Вложение[сч].Подтип);
		СтруктураВложения.Вставить("ВерсияФормата",оДокумент.Вложение[сч].ВерсияФормата);
		СтруктураВложения.Вставить("ПодВерсияФормата",оДокумент.Вложение[сч].ПодВерсияФормата);
		СтруктураВложения.Вставить("Название",оДокумент.Вложение[сч].Название);
		Если оДокумент.Вложение[сч].Свойство("Зашифрован") и оДокумент.Вложение[сч].Зашифрован="Да" Тогда
			СтруктураВложения.Вставить("Зашифрован",оДокумент.Вложение[сч].Зашифрован);	
		КонецЕсли;
		СтруктураПакета.Вложение.Добавить(СтруктураВложения);
		// для вложения ищем файлы подписей
		Для Каждого оПодпись из МассивПодписей Цикл
			Если Найти(оПодпись.ИмяБезРасширения,оФайл.Имя)>0 Тогда
				 Подпись.Добавить(Новый Структура("Файл,Направление",Новый Структура("Имя,ПолноеИмяФайла",оПодпись.Имя,оПодпись.ПолноеИмя),"Внешняя"));
			КонецЕсли;	
		КонецЦикла;	
		Если МассивПодписей.Количество()>0 Тогда
			СтруктураВложения.Вставить("Подпись",Подпись);
		КонецЕсли;	
		сч = сч+1;
	 КонецЦикла;		
	
	Возврат СтруктураПакета;
Конецфункции	
&НаКлиенте	
Функция СохранитьВложенияНаДиск(оДокумент) Экспорт
	МассивСохраненныхФайлов = Новый Массив;
	//перебираем массив вложений
	Для Каждого Вложение из оДокумент.Вложение Цикл
			СсылкаНаФайл = Вложение.Файл.Ссылка;
			ИмяФайла = ВремКаталог+Вложение.Файл.Имя;
			
			Рез = МестныйКэш.Интеграция.СохранитьВложениеПоСсылкеВФайл(МестныйКэш,СсылкаНаФайл,ИмяФайла);
			
			//если хотябы один файл не сохранен, то отправки не будет
			Если Рез=Ложь или Рез=Неопределено Тогда
				Возврат Новый Массив;
			КонецЕсли;	
			оФайл = Новый Файл(ИмяФайла);
			МассивСохраненныхФайлов.Добавить(оФайл); 
	
	КонецЦикла;	
	Возврат МассивСохраненныхФайлов;
КонецФункции
&НаКлиенте	
Функция СохранитьПодписиНаДиск(оДокумент)Экспорт
		
	МассивПодписей = Новый Массив;
	//перебираем массив вложений
	Для Каждого Вложение из оДокумент.Вложение Цикл
		//перебор файлов подписей
		Если Вложение.Свойство("Подпись") Тогда
			сч=1;
			Для Каждого ФайлПодписи из Вложение.Подпись Цикл
				СсылкаНаФайл = ФайлПодписи.Файл.Ссылка;
				ИмяФайла = ВремКаталог+ФайлПодписи.Файл.Имя;
				//избежание перезаписи файлов, если имена файлов подписей одинаковые
				тмпФайл = Новый Файл(ИмяФайла);
				Если тмпФайл.Существует() Тогда
					ИмяФайла = тмпФайл.Путь+тмпФайл.ИмяБезрасширения+"."+строка(сч)+тмпФайл.Расширение;
					сч=сч+1;
				КонецЕсли;
				Рез = МестныйКэш.Интеграция.СохранитьВложениеПоСсылкеВФайл(МестныйКэш,СсылкаНаФайл,ИмяФайла);
	 			оФайл = Новый Файл(ИмяФайла);
				МассивПодписей.Добавить(оФайл); 
			КонецЦикла;	  
		КонецЕсли;	
	КонецЦикла;	
	Возврат МассивПодписей;
КонецФункции	


//УФ
&НаКлиенте
Процедура ПриОткрытии(Отказ)
	сбисЭлементФормы(ЭтаФорма,"Отправить").Заголовок="Отправить ("+строка(СписокДокументов.Количество())+")";
	ЭтаФорма.Заголовок = "Переслать для ознакомления";
КонецПроцедуры


