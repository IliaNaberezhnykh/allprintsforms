
#Область Отладка

&НаКлиенте
Перем КомандыПечати;

&НаКлиенте
Функция ЭтоОтладка()
	
	ЭтоОтладка = ( Не Параметры.Свойство("ДополнительнаяОбработкаСсылка") или 
				   Не ЗначениеЗаполнено(Параметры.ДополнительнаяОбработкаСсылка) );
	
	Если ЭтоОтладка Тогда
		КомандыПечати = ЗаполнитьФормуОтладки();
	КонецЕсли;
	
	Возврат ЭтоОтладка;
		
КонецФункции

&НаСервере
Функция ЗаполнитьФормуОтладки()
	
	РегистрационныеДанные = РеквизитФормыВЗначение("Объект").СведенияОВнешнейОбработке();
	
	//----------------------------------------------------------------------------------------------------------------------------
	
	Если Не ТипЗнч(РегистрационныеДанные) = Тип("Структура") Тогда
		
		Сообщить(НСтр("ru = 'Не удалось получить регистрационные данные в сведениях о внешней обработке.'"));
		Возврат Неопределено;
	КонецЕсли;
	
	Если Не РегистрационныеДанные.Свойство("Назначение") или Не ЗначениеЗаполнено(РегистрационныеДанные.Назначение) Тогда
		
		Сообщить(НСтр("ru = 'Не заполнены объекты назначения в сведениях о внешней обработке.'"));
		Возврат Неопределено;
	КонецЕсли;

	Если Не РегистрационныеДанные.Свойство("Команды") или Не ЗначениеЗаполнено(РегистрационныеДанные.Команды) Тогда
		
		Сообщить(НСтр("ru = 'Не заполнены команды печати в сведениях о внешней обработке.'"));
		Возврат Неопределено;
	КонецЕсли;
	
	//----------------------------------------------------------------------------------------------------------------------------
	
	МассивТипов = Новый Массив;
	ЗаголовокОбъектаПечати = "Документ";
	
	Для Каждого ОбъектНазначения Из РегистрационныеДанные.Назначение Цикл
		Попытка
			
			СсылкаНаОбъектНазначения = ПредопределенноеЗначение(ОбъектНазначения + ".ПустаяСсылка");
			МассивТипов.Добавить( ТипЗнч(СсылкаНаОбъектНазначения) );
			
			Если ЗаголовокОбъектаПечати = "Документ" Тогда
				ПозицияТочки = СтрНайти(ОбъектНазначения, ".");
				Если Не ВРег(Лев(ОбъектНазначения, ПозицияТочки - 1)) = ВРег(ЗаголовокОбъектаПечати) Тогда
					ЗаголовокОбъектаПечати = "Объект";
				КонецЕсли;
			КонецЕсли;
			
		Исключение КонецПопытки;
	КонецЦикла;		
	
	//----------------------------------------------------------------------------------------------------------------------------
	
	Если Не ЗначениеЗаполнено(МассивТипов) Тогда
		
		Сообщить(НСтр("ru = 'Не удалось получить список объектов, к которым может быть применена данная обработка.'"));
		Возврат Неопределено;
	КонецЕсли;	
	
	//----------------------------------------------------------------------------------------------------------------------------
	
	МассивРеквизитов = Новый Массив;
	МассивРеквизитов.Добавить( Новый РеквизитФормы("СсылкаНаОбъект", Новый ОписаниеТипов(МассивТипов)) );
	ИзменитьРеквизиты(МассивРеквизитов);

	//----------------------------------------------------------------------------------------------------------------------------

	ГруппаОтладки = Элементы.Добавить("ГруппаОтладки", Тип("ГруппаФормы"));
	ГруппаОтладки.Вид         = ВидГруппыФормы.ОбычнаяГруппа;
	ГруппаОтладки.Группировка = ГруппировкаПодчиненныхЭлементовФормы.ГоризонтальнаяВсегда;
	
	ЭлементОтладки = Элементы.Добавить("ОбъектПечати", Тип("ПолеФормы"), ГруппаОтладки);
	ЭлементОтладки.Вид                       = ВидПоляФормы.ПолеВвода;
	ЭлементОтладки.ПутьКДанным               = "СсылкаНаОбъект";
	ЭлементОтладки.Заголовок                 = ЗаголовокОбъектаПечати;
	ЭлементОтладки.КнопкаВыпадающегоСписка   = Ложь;
	ЭлементОтладки.АвтоОтметкаНезаполненного = Истина;
	ЭлементОтладки.КнопкаВыбора              = Истина;
	ЭлементОтладки.ОтображениеКнопкиВыбора   = ОтображениеКнопкиВыбора.ОтображатьВПолеВвода;
	ЭлементОтладки.УстановитьДействие("ПриИзменении", "ОбъектПечатиПриИзменении");
	
	КоманднаяПанельОтладки = Элементы.Добавить("КоманднаяПанельОтладки", Тип("ГруппаФормы"), ГруппаОтладки);
	КоманднаяПанельОтладки.Вид = ВидГруппыФормы.КоманднаяПанель;
	
	ПодменюОтладки = Элементы.Добавить("ПечатьОбъекта", Тип("ГруппаФормы"), КоманднаяПанельОтладки);
	ПодменюОтладки.Вид         = ВидГруппыФормы.Подменю;
	ПодменюОтладки.Заголовок   = "Печать";
	ПодменюОтладки.Картинка    = БиблиотекаКартинок.Печать;
	ПодменюОтладки.Отображение = ОтображениеКнопки.КартинкаИТекст;
	ПодменюОтладки.Доступность = Ложь;
	
	//----------------------------------------------------------------------------------------------------------------------------
	
	МассивСтруктурКомандПечати = Новый Массив;
	Для Итер = 0 По РегистрационныеДанные.Команды.Количество() - 1 Цикл
		
		ИмяКоманды      = "КомандаПечатиНомер" + Формат(Итер, "ЧН=0; ЧГ=0");
		ИмяМакета       = РегистрационныеДанные.Команды[Итер].Идентификатор;
		ЗаголовокКнопки = РегистрационныеДанные.Команды[Итер].Представление;
		
		МассивСтруктурКомандПечати.Добавить( Новый Структура("ИмяКоманды, ИмяМакета", ИмяКоманды, ИмяМакета) );
		
		КомандаОтладки = Команды.Добавить(ИмяКоманды);
		КомандаОтладки.Действие = "ВыполнитьКомандуПечати";
		
		КнопкаОтладки = Элементы.Добавить(ИмяКоманды, Тип("КнопкаФормы"), ПодменюОтладки);
		КнопкаОтладки.Вид        = ВидКнопкиФормы.КнопкаКоманднойПанели;
		КнопкаОтладки.Заголовок  = ЗаголовокКнопки;
		КнопкаОтладки.ИмяКоманды = ИмяКоманды;
		
	КонецЦикла;
	
	//----------------------------------------------------------------------------------------------------------------------------
	
	Возврат МассивСтруктурКомандПечати; 
	
КонецФункции

&НаКлиенте
Процедура ОбъектПечатиПриИзменении(Элемент)
	
	Элементы["ПечатьОбъекта"].Доступность = ЗначениеЗаполнено( ЭтотОбъект["СсылкаНаОбъект"] );

КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьКомандуПечати(Команда)
	
	ОчиститьСообщения();
	
	МассивОбъектов = Новый Массив;
	МассивОбъектов.Добавить( ЭтотОбъект["СсылкаНаОбъект"] );
	
	Для Каждого ЭлементКоманды Из КомандыПечати Цикл
		
		Если Не ЭлементКоманды.ИмяКоманды = Команда.Имя Тогда
			Продолжить;
		КонецЕсли;	
		
		//------------------
		// Логика на клиенте
		//------------------
		
		МассивПечати = ВыполнитьКомандуПечатиНаСервере(ЭлементКоманды.ИмяМакета, МассивОбъектов);
		Для Каждого ЭлементПечати Из МассивПечати Цикл
			
			ТабличныйДокумент = ЭлементПечати.ТабличныйДокумент;
			
			Если ТипЗнч(ТабличныйДокумент) = Тип("ТабличныйДокумент") Тогда
				ТабличныйДокумент.Показать( СтрШаблон("%1 [%2]", ЭлементПечати.СинонимМакета, ЭлементПечати.ИмяМакета) );
			Иначе
				Сообщить(НСтр("ru = 'Не удалось сформировать табличный документ.'"));
			КонецЕсли;
			
		КонецЦикла;
			
		Прервать;
			
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Функция ВыполнитьКомандуПечатиНаСервере(ИмяМакета, МассивОбъектов)
	
	КоллекцияПечатныхФорм = ПодготовитьКоллекциюПечатныхФорм(ИмяМакета);
	
	РеквизитФормыВЗначение("Объект").Печать( МассивОбъектов, 
						   					 КоллекцияПечатныхФорм, 
						   					 Новый СписокЗначений, 
						   					 ПодготовитьСтруктуруПараметровВывода() );
	МассивПечати = Новый Массив;
	
	Для Каждого ЭлементКоллекции Из КоллекцияПечатныхФорм Цикл
		
		ЭлементПечати = Новый Структура("ТабличныйДокумент, ИмяМакета, СинонимМакета");
		ЗаполнитьЗначенияСвойств(ЭлементПечати, ЭлементКоллекции);
		МассивПечати.Добавить( ЭлементПечати );
		
	КонецЦикла;
											  
	Возврат МассивПечати;
					   
КонецФункции

#Область УправлениеПечатью

&НаСервере
Функция ПодготовитьКоллекциюПечатныхФорм(Знач Идентификаторы)
	
	Результат = Новый ТаблицаЗначений;
	Для Каждого ИмяКолонки Из ИменаПолейКоллекцииПечатныхФорм() Цикл
		Результат.Колонки.Добавить(ИмяКолонки);
	КонецЦикла;
	
	Если ТипЗнч(Идентификаторы) = Тип("Строка") Тогда
		Идентификаторы = СтрРазделить(Идентификаторы, ",");
	КонецЕсли;
	
	Для Каждого Идентификатор Из Идентификаторы Цикл
		ПечатнаяФорма = Результат.Найти(Идентификатор, "ИмяМакета");
		Если ПечатнаяФорма = Неопределено Тогда
			ПечатнаяФорма = Результат.Добавить();
			ПечатнаяФорма.ИмяМакета = Идентификатор;
			ПечатнаяФорма.ИмяВРЕГ = ВРег(Идентификатор);
			ПечатнаяФорма.Экземпляров = 1;
		Иначе
			ПечатнаяФорма.Экземпляров = ПечатнаяФорма.Экземпляров + 1;
		КонецЕсли;
	КонецЦикла;
	
	Результат.Индексы.Добавить("ИмяВРЕГ");
	Возврат Результат;
	
КонецФункции

&НаСервере
Функция ПодготовитьСтруктуруПараметровВывода()
	
	ПараметрыВывода = Новый Структура;
	ПараметрыВывода.Вставить("ДоступнаПечатьПоКомплектно", Ложь); // не используется
	
	СтруктураПараметровПисьма = Новый Структура("Получатель,Тема,Текст", Неопределено, "", "");
	ПараметрыВывода.Вставить("ПараметрыОтправки", СтруктураПараметровПисьма);
	
	Возврат ПараметрыВывода;
	
КонецФункции

#КонецОбласти 

#Область УправлениеПечатьюКлиентСервер

&НаСервере
Функция ИменаПолейКоллекцииПечатныхФорм()
	
	Поля = Новый Массив;
	Поля.Добавить("ИмяМакета");
	Поля.Добавить("ИмяВРЕГ");
	Поля.Добавить("СинонимМакета");
	Поля.Добавить("ТабличныйДокумент");
	Поля.Добавить("Экземпляров");
	Поля.Добавить("Картинка");
	Поля.Добавить("ПолныйПутьКМакету");
	Поля.Добавить("ИмяФайлаПечатнойФормы");
	Поля.Добавить("ОфисныеДокументы");
	
	Возврат Поля;
	
КонецФункции

#КонецОбласти

#КонецОбласти


#Область ОбработчикиСобытийФормы

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Если ЭтоОтладка() Тогда
		Возврат;
	КонецЕсли;	
	
	//------------------
	// Логика на клиенте
	//------------------
	
	//ПараметрыПечати = Новый Структура;
	//Если ТипЗнч(Параметры.ОбъектыНазначения) = Тип("Массив") И Параметры.ОбъектыНазначения.Количество() = 1 Тогда 
	//	ПараметрыПечати.Вставить("ЗаголовокФормы", Параметры.ОбъектыНазначения[0]);
	//КонецЕсли;
	//
	//ПараметрыИсточника = Новый Структура("ИдентификаторКоманды, ОбъектыНазначения");
	//ПараметрыИсточника.ИдентификаторКоманды = Параметры.ИдентификаторКоманды;
	//ПараметрыИсточника.ОбъектыНазначения	= Параметры.ОбъектыНазначения;
	//
	//ПараметрыОткрытия = Новый Структура("ИсточникДанных, ПараметрыИсточника, ПараметрыПечати");
	//ПараметрыОткрытия.ИсточникДанных     = Параметры.ДополнительнаяОбработкаСсылка;
	//ПараметрыОткрытия.ПараметрыИсточника = ПараметрыИсточника;
	//ПараметрыОткрытия.ПараметрыПечати    = ПараметрыПечати;
	//
	//ОткрытьФорму("ОбщаяФорма.ПечатьДокументов", ПараметрыОткрытия);	
	//
	//Закрыть();
	
КонецПроцедуры

#КонецОбласти
