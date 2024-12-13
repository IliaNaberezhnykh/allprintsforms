
&НаКлиенте
Функция ПолучитьДанныеИзДокумента1С(Кэш,Контекст) Экспорт
	// Функция формирует структуру выгружаемого файла И добавляет его в состав пакета
	Попытка	
		Контекст.Вставить("ТаблДок",Новый Структура());
		Контекст.ТаблДок.Вставить("ИтогТабл",Новый Массив);
		Контекст.ТаблДок.Вставить("СтрТабл",Новый Массив);
		Контекст.Вставить("ИтогСумма",0);
		Контекст.Вставить("ИтогСуммаБезНалога",0);
		Контекст.Вставить("ИтогБрутто",0);
		Контекст.Вставить("ИтогНетто",0);
		
		НоменклатураКодКонтрагента = Кэш.ОбщиеФункции.РассчитатьЗначение("НоменклатураКодКонтрагента", Контекст.ФайлДанные,Кэш);  // надо сопоставить номенклатуру перед отправкой
		Если ЗначениеЗаполнено(НоменклатураКодКонтрагента) Тогда
			Контекст.Вставить("НоменклатураКодКонтрагента",НоменклатураКодКонтрагента);	
		КонецЕсли;
		
		ПолучитьТабличнуюЧастьДокумента1С(Кэш,Контекст);
		Если Контекст.ТаблДок.СтрТабл.Количество() = 0 Тогда//нет такого документа
			Возврат Истина;
		КонецЕсли;
		
		ИтогТабл=Новый Структура;
		ИтогТабл.Вставить("Сумма", Формат(Контекст.ИтогСумма, "ЧЦ=17; ЧДЦ=2; ЧРД=.; ЧГ=0; ЧН=0.00"));	
		ИтогТабл.Вставить("СуммаБезНДС", Формат(Контекст.ИтогСуммаБезНалога, "ЧЦ=17; ЧДЦ=2; ЧРД=.; ЧГ=0; ЧН=0.00"));
		
		Если Контекст.ФайлДанные.Свойство("ЕдиницаИзмеренияВеса") Тогда
			ЕдиницаИзмеренияВеса = Контекст.ФайлДанные.ЕдиницаИзмеренияВеса;
			Если Контекст.ИтогБрутто > 0 Тогда
				ИтогТаблБрутто = Новый Структура;
				ИтогТаблБрутто.Вставить("Кол_во", Формат(Контекст.ИтогБрутто, "ЧЦ=17; ЧДЦ=3; ЧРД=.; ЧГ=0; ЧН=0.00"));
				Если Контекст.ФайлДанные.Свойство("МассаИтогПрописью") Тогда
					Контекст.ФайлДанные.Вставить("МассаИтог", Контекст.ИтогБрутто);
					ИтогТаблБрутто.Вставить("Прописью", Кэш.ОбщиеФункции.РассчитатьЗначение("МассаИтогПрописью", Контекст.ФайлДанные,Кэш));
				Иначе	
					ИтогТаблБрутто.Вставить("Прописью", ЧислоПрописью(Контекст.ИтогБрутто, ,",,,,,,,,0")+ " " + СокрЛП(ЕдиницаИзмеренияВеса) + ".");
				КонецЕсли;	
				ИтогТабл.Вставить("Брутто", ИтогТаблБрутто);
			КонецЕсли;
			
			Если Контекст.ИтогНетто > 0 Тогда
				ИтогТаблНетто = Новый Структура;
				ИтогТаблНетто.Вставить("Кол_во", Формат(Контекст.ИтогНетто, "ЧЦ=17; ЧДЦ=3; ЧРД=.; ЧГ=0; ЧН=0.00"));
				Если Контекст.ФайлДанные.Свойство("МассаИтогПрописью") Тогда
					Контекст.ФайлДанные.Вставить("МассаИтог", Контекст.ИтогНетто);
					ИтогТаблНетто.Вставить("Прописью", Кэш.ОбщиеФункции.РассчитатьЗначение("МассаИтогПрописью", Контекст.ФайлДанные,Кэш));
				Иначе	
					ИтогТаблНетто.Вставить("Прописью", ЧислоПрописью(Контекст.ИтогНетто, ,",,,,,,,,0")+ " " + СокрЛП(ЕдиницаИзмеренияВеса) + ".");
				КонецЕсли;	
				ИтогТабл.Вставить("Нетто", ИтогТаблНетто);
			КонецЕсли;
		КонецЕсли;
		
		Контекст.ТаблДок.ИтогТабл.Добавить(ИтогТабл);
		
		Док  = Новый Структура;
		Док.Вставить("Файл",Новый Структура);
		Кэш.ОбщиеФункции.ЗаполнитьАтрибуты(Кэш,"Файл",Контекст.ФайлДанные,Док.Файл);
		Док.Файл.Вставить("Документ",Новый Структура);
		Кэш.ОбщиеФункции.ЗаполнитьАтрибуты(Кэш,"Документ",Контекст.ФайлДанные,Док.Файл.Документ);
		
		Валюта =  Кэш.ОбщиеФункции.РассчитатьЗначение("Валюта_КодОКВ", Контекст.ФайлДанные, Кэш);
		Если ЗначениеЗаполнено(Валюта) Тогда
			Док.Файл.Документ.Вставить("Валюта",Новый Структура);
			Кэш.ОбщиеФункции.ЗаполнитьАтрибуты(Кэш,"Валюта",Контекст.ФайлДанные,Док.Файл.Документ.Валюта);
		КонецЕсли;
		
		Если Контекст.ФайлДанные.Свойство("мПараметр") Тогда
			СписокПараметр=Новый Массив;
			Для Каждого Элемент Из Контекст.ФайлДанные.мПараметр Цикл
				Кэш.ОбщиеФункции.сбисСкопироватьСтруктуруНаКлиенте(Контекст.ФайлДанные,Элемент.Значение);
				Параметр = Новый Структура();
				Кэш.ОбщиеФункции.ЗаполнитьАтрибуты(Кэш,"Параметр",Контекст.ФайлДанные,Параметр);
				СписокПараметр.Добавить(Параметр);
			КонецЦикла;
			Док.Файл.Документ.Вставить("СписокПараметр",Новый структура("Параметр",СписокПараметр));
		КонецЕсли;
		
		Если Контекст.ФайлДанные.Свойство("мОснование") Тогда
			ПолучитьДанныеИзДокумента1С_мОснование(Кэш, Док, Контекст);
		КонецЕсли;
		
		Отправитель = "";
		Получатель = "";  
		ЗапретРедакций = Ложь;
		ОтправительРоль=Кэш.ОбщиеФункции.РассчитатьЗначение("Отправитель_Роль", Контекст.ФайлДанные, Кэш);
		ПолучательРоль=Кэш.ОбщиеФункции.РассчитатьЗначение("Получатель_Роль", Контекст.ФайлДанные, Кэш);
		Если Не ЗначениеЗаполнено(ОтправительРоль) Тогда
			ОтправительРоль = "Отправитель";
		КонецЕсли;
		Если Не ЗначениеЗаполнено(ПолучательРоль) Тогда
			ПолучательРоль = "Получатель";
		КонецЕсли;
		Если Контекст.ФайлДанные.Свойство("мСторона") Тогда
			Стороны=Новый структура;
			Для Каждого Параметр Из Контекст.ФайлДанные.мСторона Цикл
				Если Параметр.Значение.Свойство("Роль") Тогда
					Роль = Кэш.ОбщиеФункции.РассчитатьЗначение("Роль",Параметр.Значение,Кэш);
				Иначе
					Роль = Кэш.ОбщиеФункции.РассчитатьЗначение("Сторона_Роль",Параметр.Значение,Кэш);
				КонецЕсли;
				Если Роль = ОтправительРоль Тогда
					Сертификат = Кэш.ОбщиеФункции.РассчитатьЗначение("Сертификат",Параметр.Значение,Кэш);
				КонецЕсли;     
				Если Роль = ПолучательРоль Тогда
					ЗапретРедакций = Кэш.ОбщиеФункции.РассчитатьЗначение("ЗапретРедакций",Параметр.Значение,Кэш);
				КонецЕсли;
				Сторона = Кэш.ОбщиеФункции.ПолучитьСторону(Кэш,Параметр.Значение);     //?????
				Если Сторона<>Неопределено Тогда
					Если Сторона.свойство("Адрес") Тогда
						КопияСторонаАдрес = Кэш.ОбщиеФункции.сбисСкопироватьОбъектНаКлиенте(Сторона.Адрес);// alo копия чтобы не порушить кэшируемые значения 
						Для Каждого адресТип из КопияСторонаАдрес Цикл 
							Если адресТип.свойство("Тип") И ЗначениеЗаполнено(адресТип.Тип) Тогда
								тип= адресТип.Тип;
								адресТип.Удалить("Тип");
							Иначе
								тип= "Юридический";
							КонецЕсли;
							Если Не адресТип.свойство(тип) Тогда
								адресТип.Вставить(тип,Новый структура());
								Если адресТип.свойство("АдрТекст") Тогда
									Если Не адресТип.свойство("АдрИно") И Не адресТип.свойство("АдрРФ") Тогда
										адресТип[тип].вставить("АдрТекст",адресТип.АдрТекст);
									КонецЕсли;
									адресТип.Удалить("АдрТекст");
								КонецЕсли;
								Если адресТип.свойство("АдрИно") Тогда
									адресТип[тип].вставить("АдрИно",адресТип.АдрИно);
									адресТип.Удалить("АдрИно");
								КонецЕсли;
								Если адресТип.свойство("АдрРФ") Тогда
									адресТип[тип].вставить("АдрРФ",адресТип.АдрРФ);
									адресТип.Удалить("АдрРФ");
								КонецЕсли;
							КонецЕсли;
						Конеццикла;
						Сторона.Вставить("Адрес",КопияСторонаАдрес);
					КонецЕсли;
					Если Сторона.свойство("Представители") Тогда
						Сторона.Удалить("Представители");
					КонецЕсли;
					Стороны.Вставить(Роль,Сторона);
				КонецЕсли;
			КонецЦикла;
			Если Не Стороны.Свойство(ПолучательРоль) Тогда
				Сообщить("Не удалось определить ИНН получателя документа "+строка(Контекст.Документ));
				Возврат Ложь;
			КонецЕсли;
			Если Не Стороны.Свойство(ОтправительРоль) Тогда
				Сообщить("Не удалось определить ИНН отправителя документа "+строка(Контекст.Документ));
				Возврат Ложь;
			КонецЕсли;
			// Если Грузоотправитель И грузополучатель нужны, но они Не попали в файл, то берем их с отправителя И получателя
			Если Не Контекст.Свойство("ЗаполнятьГрузотпрГрузполуч") Или (Контекст.Свойство("ЗаполнятьГрузотпрГрузполуч") И Контекст.ЗаполнятьГрузотпрГрузполуч = Истина) Тогда
				Если Контекст.ФайлДанные.мСторона.Свойство("Грузоотправитель") И Не Стороны.Свойство("Грузоотправитель") И Стороны.Свойство(ОтправительРоль) Тогда
					Стороны.Вставить("Грузоотправитель",Новый Структура);		
					Кэш.ОбщиеФункции.сбисСкопироватьСтруктуруНаКлиенте(Стороны.Грузоотправитель,Стороны[ОтправительРоль]);
				КонецЕсли;
				Если Контекст.ФайлДанные.мСторона.Свойство("Грузополучатель") И Не Стороны.Свойство("Грузополучатель") И Стороны.Свойство(ПолучательРоль) Тогда
					Стороны.Вставить("Грузополучатель",Новый Структура);		
					Кэш.ОбщиеФункции.сбисСкопироватьСтруктуруНаКлиенте(Стороны.Грузополучатель,Стороны[ПолучательРоль]);
				КонецЕсли;
			КонецЕсли;
			Отправитель = Кэш.ОбщиеФункции.сбисСкопироватьОбъектНаКлиенте(Стороны[ОтправительРоль]); 
			Получатель = Кэш.ОбщиеФункции.сбисСкопироватьОбъектНаКлиенте(Стороны[ПолучательРоль]); 
			Если ЗапретРедакций = Истина Тогда
				Получатель.Вставить("ЗапретРедакций", Истина);		
			КонецЕсли;
			Док.Файл.Документ.Вставить("Стороны",Стороны);
		КонецЕсли;
		Если Док.Файл.Свойство("Имя") Тогда
			Если Контекст.ФайлДанные.Свойство("мСторона") И Док.Файл.Документ.Стороны[ПолучательРоль].Свойство("Идентификатор") И Док.Файл.Документ.Стороны[ОтправительРоль].Свойство("Идентификатор") Тогда
				Док.Файл.Имя = Док.Файл.Имя + Док.Файл.Документ.Стороны[ПолучательРоль].Идентификатор+"_"+Док.Файл.Документ.Стороны[ОтправительРоль].Идентификатор;
			КонецЕсли;
			Док.Файл.Имя = Док.Файл.Имя+"_"+Формат(ТекущаяДата(),"ДФ=ггггММдд")+"_"+строка(Новый УникальныйИдентификатор());
		КонецЕсли;
		
		ОтветственныйСтруктура = Кэш.ОбщиеФункции.ПолучитьСтруктуруОтветственного(Кэш,Контекст);
		ПодразделениеСтруктура = Кэш.ОбщиеФункции.ПолучитьСтруктуруПодразделения(Кэш,Контекст);
		РегламентСтруктура = Кэш.ОбщиеФункции.ПолучитьСтруктуруРегламента(Кэш,Контекст);
		ОснованияМассив = Кэш.ОбщиеФункции.ПолучитьМассивОснований(Кэш,Контекст);  
		СвязанныеДокументы1С = Кэш.ОбщиеФункции.сбисПолучитьСвязанныеДокументы1С(Кэш,Контекст);
		ДатаВложения = ?(Док.Файл.Документ.Свойство("Дата"), Док.Файл.Документ.Дата, "");
		НомерВложения = ?(Док.Файл.Документ.Свойство("Номер"), Док.Файл.Документ.Номер, "");
		СуммаВложения = Формат(Контекст.ИтогСумма, "ЧЦ=17; ЧДЦ=2; ЧРД=.; ЧГ=0; ЧН=0.00");
		НазваниеВложения = ?(Док.Файл.Документ.Свойство("Название"), Док.Файл.Документ.Название+" № "+НомерВложения+" от "+ДатаВложения+" на сумму "+СуммаВложения, "");
		Тип = Кэш.ОбщиеФункции.РассчитатьЗначение("Вложение_Тип", Контекст.ФайлДанные,Кэш);
		ПодТип = Кэш.ОбщиеФункции.РассчитатьЗначение("Вложение_ПодТип", Контекст.ФайлДанные,Кэш);
		ВерсияФормата = Кэш.ОбщиеФункции.РассчитатьЗначение("Вложение_ВерсияФормата", Контекст.ФайлДанные,Кэш);
		ПодВерсияФормата = Кэш.ОбщиеФункции.РассчитатьЗначение("Вложение_ПодВерсияФормата", Контекст.ФайлДанные,Кэш);
		Примечание = Кэш.ОбщиеФункции.РассчитатьЗначение("Примечание", Контекст.ФайлДанные,Кэш);
		Провести = Кэш.ОбщиеФункции.РассчитатьЗначение("Провести", Контекст.ФайлДанные,Кэш); // alo Провести
		ИспользоватьГенератор = Кэш.ОбщиеФункции.РассчитатьЗначение("ИспользоватьГенератор", Контекст.ФайлДанные,Кэш);
		
		Док.Файл.Документ.Вставить("СписокСтрТабл", Контекст.ТаблДок);
		Вложение = Новый Структура("СтруктураДокумента,Отправитель,Получатель,Ответственный,Подразделение,Регламент,ДокументОснование, Документ1С, Название, Тип, ПодТип, ВерсияФормата,ПодВерсияФормата,Дата,Номер,Сумма", Док,Отправитель,Получатель,ОтветственныйСтруктура,ПодразделениеСтруктура,РегламентСтруктура,ОснованияМассив, Контекст.Документ, НазваниеВложения, Тип, ПодТип, ВерсияФормата,ПодВерсияФормата,ДатаВложения,НомерВложения,СуммаВложения);
		Если ЗначениеЗаполнено(НоменклатураКодКонтрагента) Тогда
			Вложение.Вставить("НоменклатураКодКонтрагента",НоменклатураКодКонтрагента);	
		КонецЕсли;
		Если ЗначениеЗаполнено(Примечание) Тогда
			Вложение.Вставить("Примечание",Примечание);	
		КонецЕсли;
		Если ЗначениеЗаполнено(Сертификат) Тогда
			Вложение.Вставить("Сертификат",Сертификат);	
		КонецЕсли;
		Если ТипЗнч(ИспользоватьГенератор) = Тип("Булево") Тогда
			Вложение.Вставить("ИспользоватьГенератор", ИспользоватьГенератор);
		КонецЕсли;
		ДопПоля = Новый Структура;	// alo ДопПоля
		Кэш.ОбщиеФункции.ЗаполнитьАтрибуты(Кэш,"ДопПоля",Контекст.ФайлДанные,ДопПоля);
		Если ЗначениеЗаполнено(ДопПоля) Тогда
			Вложение.Вставить("ДопПоля",ДопПоля);
		Конецесли;
		Если ЗначениеЗаполнено(Провести) Тогда // alo Провести
			Вложение.Вставить("Провести",Провести);	
		КонецЕсли;  
		Если ЗначениеЗаполнено(СвязанныеДокументы1С) Тогда
			СвязанныеДокументы1С.Вставить(0, Контекст.Документ);
			Вложение.Вставить("Документы1С",СвязанныеДокументы1С);	
		КонецЕсли;
		Контекст.СоставПакета.Вложение.Добавить(Вложение);
		//TODO временное решение, потом убрать {
		Если Кэш.ОбщиеФункции.ГенераторВключенДляДокумента(Кэш, Контекст.ФайлДанные) Тогда
			Сделка = Неопределено;
			Если Контекст.ФайлДанные.Свойство("мОснование") Тогда
				Для Каждого Параметр Из Контекст.ФайлДанные.мОснование Цикл
					Если ТипЗнч(Параметр.Значение) = Тип("Массив") Тогда
						Продолжить;
					КонецЕсли;
					Если Параметр.Ключ = "Сделка" ИЛИ Параметр.Ключ = "Заказ" Тогда
						Сделка = Новый Структура();
						Если НЕ ПустаяСтрока(Параметр.Значение.Основание_Номер) Тогда
							Сделка.Вставить("ЗаказНомер", Новый Структура("Имя, Значение", "ЗаказНомер", Параметр.Значение.Основание_Номер));	
						КонецЕсли;
						Если НЕ ПустаяСтрока(Параметр.Значение.Основание_Дата) Тогда
							Сделка.Вставить("ЗаказДата", Новый Структура("Имя, Значение", "ЗаказДата", Параметр.Значение.Основание_Дата));	
						КонецЕсли;
					КонецЕсли;
				КонецЦикла;
				Если Сделка <> Неопределено Тогда
					Если НЕ Контекст.ФайлДанные.Свойство("мПараметр") Тогда
						Док.Файл.Документ.Вставить("СписокПараметр",Новый Структура("Параметр", Новый Массив));
					КонецЕсли;
					Если Сделка.Свойство("ЗаказНомер") Тогда
						Док.Файл.Документ.СписокПараметр.Параметр.Добавить(Сделка.ЗаказНомер);
					КонецЕсли;
					Если Сделка.Свойство("ЗаказДата") Тогда
						Док.Файл.Документ.СписокПараметр.Параметр.Добавить(Сделка.ЗаказДата);
					КонецЕсли;
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;
		// }
		фрм = Кэш.ГлавноеОкно.сбисНайтиФормуФункции("СформироватьДокументДляГенератора","Файл_"+Контекст.ФайлДанные.Файл_Формат+"_"+СтрЗаменить(СтрЗаменить(Контекст.ФайлДанные.Файл_ВерсияФормата, ".", "_"), " ", ""),"Файл_Шаблон", Кэш);
		Если фрм<>Ложь Тогда
			фрм.СформироватьДокументДляГенератора(Кэш, Док, Контекст, Вложение);	
			Вложение.СтруктураДокумента = Док;
		КонецЕсли;
		фрм = Кэш.ГлавноеОкно.сбисНайтиФормуФункции("сбисПослеФормированияДокумента","Файл_"+Контекст.ФайлДанные.Файл_Формат+"_"+СтрЗаменить(СтрЗаменить(Контекст.ФайлДанные.Файл_ВерсияФормата, ".", "_"), " ", ""),"Файл_Шаблон", Кэш);
		Если фрм<>Ложь Тогда
			фрм.сбисПослеФормированияДокумента(Док, Кэш, Контекст);	
			Вложение.СтруктураДокумента = Док; // на случай, Если Док поменялся в функции сбисПослеФормированияДокумента
		КонецЕсли;
		Возврат Истина;
		
	Исключение
		Если Кэш.Свойство("РезультатОтправки") Тогда
			Кэш.РезультатОтправки.НеСформировано = Кэш.РезультатОтправки.НеСформировано+1;
			Кэш.РезультатОтправки.ОшибкиДоОтправки = Кэш.РезультатОтправки.ОшибкиДоОтправки + 1;
			Кэш.ОбщиеФункции.ДобавитьОшибкуВРезультатОтправки(Кэш, "Документ не сформирован", ОписаниеОшибки(), Контекст.Документ, 726)
		КонецЕсли;
		Сообщить(ОписаниеОшибки());
		Возврат Ложь;
	КонецПопытки;
КонецФункции

&НаКлиенте
Функция ПолучитьТабличнуюЧастьДокумента1С(Кэш,Контекст) Экспорт
	// Функция формирует структуру табличной части файла	
	СуммаВключаетНДС=Кэш.ОбщиеФункции.РассчитатьЗначение("СуммаВключаетНДС", Контекст.ФайлДанные,Кэш);
	КолТоваров = 0;
	// проверяем надо ли пересчитывать суммы в валюту учета
	Валюта = Кэш.ОбщиеФункции.РассчитатьЗначение("Валюта", Контекст.ФайлДанные,Кэш);
	ВалютаУчета = Кэш.ОбщиеФункции.РассчитатьЗначение("ВалютаУчета", Контекст.ФайлДанные,Кэш);
	
	Для Каждого Параметр Из Контекст.ФайлДанные.мТаблДок Цикл
		// Чтобы одна И та же табличная часть Не попадала 2 раза в документ (в СФ, Если по документу-основанию формируются дополнительные файлы)
		Если Контекст.Свойство("СписокТЧ") Тогда  
			Если Контекст.СписокТЧ.НайтиПоЗначению(Параметр.Ключ)<>Неопределено Тогда
				Продолжить;
			Иначе
				Контекст.СписокТЧ.Добавить(Параметр.Ключ);
			КонецЕсли;
		КонецЕсли;		
		
		Если ТипЗнч(Параметр.Значение) = Тип("Массив") Тогда    // стандартная табличная часть
			ТабЧастьДокумента = Параметр.Значение;
		ИначеЕсли ТипЗнч(Параметр.Значение) = Тип("Структура") И Лев(Параметр.Значение.ТаблДок,1)<>"{" Тогда  // табличная часть из одной строки, которая заполняется прямо из реквизитов документа
			ТабЧастьДокумента = Новый Массив;
			ТабЧастьДокумента.Добавить(Параметр.Значение);
		Иначе   // табличная часть вычисляется с помощью функции
			Кэш.ОбщиеФункции.сбисСкопироватьСтруктуруНаКлиенте(Контекст.ФайлДанные, Параметр.Значение);
			ТабЧастьДокумента = Кэш.ОбщиеФункции.РассчитатьЗначение("ТаблДок", Контекст.ФайлДанные, Кэш);
		КонецЕсли;
		
		Если ТипЗнч(ТабЧастьДокумента) = Тип("Массив") Тогда
			сч=0;
			Для Каждого Стр Из ТабЧастьДокумента Цикл
				Если Кэш.Парам.ОтправлятьНоменклатуруСДокументами = Истина И Кэш.Ини.Свойство("Номенклатура") Тогда
					Номенклатура = Кэш.ОбщиеФункции.РассчитатьЗначение("Номенклатура", Стр, Кэш);
					Если Кэш.СписокНоменклатуры.НайтиПоЗначению(Номенклатура) = Неопределено Тогда
						Кэш.СписокНоменклатуры.Добавить(Номенклатура);
					КонецЕсли;
				КонецЕсли;
				ДобавлятьСтроку = ?(Стр.Свойство("ДобавлятьСтроку"),Стр.ДобавлятьСтроку,Истина);
				сч=сч+1;
				Стр.Вставить("РеквизитСопоставленияНоменклатуры", Кэш.КэшЗначенийИни.РеквизитСопоставленияНоменклатуры);
				Стр.Вставить("СуммаВключаетНДС",СуммаВключаетНДС);
				НоваяСтрока = Новый Структура;
				Кэш.ОбщиеФункции.ЗаполнитьАтрибуты(Кэш,"ТаблДок",Стр,НоваяСтрока);
				НоваяСтрока.Вставить("ПорНомер",Формат(сч, "ЧГ=0")); 
				СуммаНДС = Кэш.ОбщиеФункции.РассчитатьЗначение("СуммаНДС", Стр, Кэш);
				Попытка
					СуммаНДС = Число(СуммаНДС);
				Исключение
					СуммаНДС = 0;
				КонецПопытки;
				Попытка
					НоваяСтрока.Сумма = Число(НоваяСтрока.Сумма);
				Исключение
					НоваяСтрока.Сумма = 0;
				КонецПопытки;
				НоваяСтрока.Вставить("СуммаБезНал",формат(НоваяСтрока.Сумма - ?(СуммаВключаетНДС, СуммаНДС, 0), "ЧЦ=17; ЧДЦ=2; ЧРД=.; ЧГ=0; ЧН=0.00"));
				НоваяСтрока.Сумма = формат(Число(НоваяСтрока.Сумма) + ?(СуммаВключаетНДС, 0, СуммаНДС), "ЧЦ=17; ЧДЦ=2; ЧРД=.; ЧГ=0; ЧН=0.00");
				
				СтруктураПроизводитель = Новый Структура;
				Кэш.ОбщиеФункции.ЗаполнитьАтрибуты(Кэш,"Производитель",Стр,СтруктураПроизводитель);
				Если СтруктураПроизводитель.Количество()>0 Тогда
					НоваяСтрока.Вставить("Производитель",СтруктураПроизводитель);
				КонецЕсли;
				НоваяСтрока.Вставить("НДС",Новый Структура);
				НоваяСтрока.НДС.Вставить( "Сумма", формат(СуммаНДС, "ЧЦ=17; ЧДЦ=2; ЧРД=.; ЧГ=0; ЧН=0.00"));	
				Если значениеЗаполнено(Стр.СтавкаНДС) И Строка(Стр.СтавкаНДС) <> "Без НДС" Тогда
					фрм = Кэш.ГлавноеОкно.сбисНайтиФормуФункции("ЗначениеИТипСтавки","РаботаСДокументами1С","",Кэш);
					СтрСтавка = фрм.ЗначениеИТипСтавки(Стр.СтавкаНДС);
					НоваяСтрока.НДС.Вставить( "Ставка", СтрСтавка.Ставка);	
				КонецЕсли;
				
				Если Стр.Свойство("мПараметр") Тогда
					СписокПараметр=Новый Массив;
					Для Каждого Элемент Из Стр.мПараметр Цикл
						Кэш.ОбщиеФункции.сбисСкопироватьСтруктуруНаКлиенте(Стр,Элемент.Значение);
						Параметр = Новый Структура();
						Кэш.ОбщиеФункции.ЗаполнитьАтрибуты(Кэш,"Параметр",Стр,Параметр);
						СписокПараметр.Добавить(Параметр);
					КонецЦикла;
					НоваяСтрока.Вставить("СписокПараметр",Новый структура("Параметр",СписокПараметр));
				КонецЕсли;
				
				СтруктураУпаковка = Новый Структура;
				Кэш.ОбщиеФункции.ЗаполнитьАтрибуты(Кэш,"Упаковка",Стр,СтруктураУпаковка);
				Если СтруктураУпаковка.Количество()>0 Тогда
					НоваяСтрока.Вставить("Упаковка",СтруктураУпаковка);
				КонецЕсли;
				
				СтруктураБрутто = Новый Структура;
				Кэш.ОбщиеФункции.ЗаполнитьАтрибуты(Кэш,"Брутто",Стр,СтруктураБрутто);
				Если СтруктураБрутто.Количество()>0 Тогда
					НоваяСтрока.Вставить("Брутто",СтруктураБрутто);
				КонецЕсли;
				
				фрм = Кэш.ГлавноеОкно.сбисНайтиФормуФункции("сбисПослеФормированияСтроки","Файл_"+Контекст.ФайлДанные.Файл_Формат+"_"+СтрЗаменить(СтрЗаменить(Контекст.ФайлДанные.Файл_ВерсияФормата, ".", "_"), " ", ""),"Файл_Шаблон", Кэш);
				Если фрм<>Ложь Тогда
					ДобавлятьСтроку = фрм.сбисПослеФормированияСтроки(НоваяСтрока, Кэш, Контекст, Стр);	
				КонецЕсли;
				// При необходимости проверяем, вся ли номенклатура сопоставлена
				Если Контекст.Свойство("НоменклатураКодКонтрагента") И (Не НоваяСтрока.Свойство(Контекст.НоменклатураКодКонтрагента) Или Не ЗначениеЗаполнено(НоваяСтрока[Контекст.НоменклатураКодКонтрагента]))  Тогда
					Контекст.СоставПакета.Вставить("Ошибка","Не вся номенклатура сопоставлена");	
				КонецЕсли;
				
				Если ДобавлятьСтроку = Ложь Тогда      // <>Ложь написано для совместимости со старыми функциями сбисПослеФормированияСтроки, которые могли ничего Не возвращать
					Продолжить;
				КонецЕсли;
				Контекст.ИтогСумма       	= Контекст.ИтогСумма + НоваяСтрока.Сумма;
				Контекст.ИтогСуммаБезНалога = Контекст.ИтогСуммаБезНалога + НоваяСтрока.СуммаБезНал;
				
				КонтекстИтог = Неопределено;
				КонтекстКолВо = НоваяСтрока;
				Если	Контекст.Свойство("ИтогБрутто", КонтекстИтог)
					И	КонтекстКолВо.Свойство("Брутто", КонтекстКолВо)
					И	КонтекстКолВо.Свойство("Кол_во", КонтекстКолВо) Тогда
					Контекст.ИтогБрутто = КонтекстИтог + КонтекстКолВо;
				КонецЕсли;
				КонтекстКолВо = НоваяСтрока;
				Если	Контекст.Свойство("ИтогНетто", КонтекстИтог)
					И	КонтекстКолВо.Свойство("Нетто", КонтекстКолВо)
					И	КонтекстКолВо.Свойство("Кол_во", КонтекстКолВо) Тогда
					Контекст.ИтогНетто = КонтекстИтог + КонтекстКолВо;
				КонецЕсли;
				Контекст.ТаблДок.СтрТабл.Добавить(НоваяСтрока);
			КонецЦикла;
		КонецЕсли;
	КонецЦикла;
КонецФункции	

&НаКлиенте
Процедура ПолучитьДанныеИзДокумента1С_мОснование(Кэш, Док, Контекст) Экспорт
	СписокОснование=Новый Массив;
	Для Каждого Параметр Из Контекст.ФайлДанные.мОснование Цикл
		Если ТипЗнч(Параметр.Значение) = Тип("Массив") Тогда
			Для Каждого Элемент Из Параметр.Значение Цикл
				ВременныйКонтекстФайлДанные = Кэш.ОбщиеФункции.СкопироватьОбъектСПараметрамиКлиент(Контекст.ФайлДанные,,Ложь);
				Кэш.ОбщиеФункции.сбисСкопироватьСтруктуруНаКлиенте(ВременныйКонтекстФайлДанные,Элемент);
				Основание = Новый Структура();
				Кэш.ОбщиеФункции.ЗаполнитьАтрибуты(Кэш,"Основание",ВременныйКонтекстФайлДанные,Основание);
				СписокОснование.Добавить(Основание);	
			КонецЦикла;
		Иначе
			ВременныйКонтекстФайлДанные = Кэш.ОбщиеФункции.СкопироватьОбъектСПараметрамиКлиент(Контекст.ФайлДанные,,Ложь);
			Кэш.ОбщиеФункции.сбисСкопироватьСтруктуруНаКлиенте(ВременныйКонтекстФайлДанные,Параметр.Значение);
			Основание = Новый Структура();
			Кэш.ОбщиеФункции.ЗаполнитьАтрибуты(Кэш,"Основание",ВременныйКонтекстФайлДанные,Основание);
			СписокОснование.Добавить(Основание);
		КонецЕсли;
	КонецЦикла;
	Док.Файл.Документ.Вставить("СписокОснование",Новый структура("Основание",СписокОснование));
КонецПроцедуры

//Генератор ФЭД для формирования вложений {
&НаКлиенте
Функция ИсточникДанных_ПолучитьДанныеСтороныПоИмени(Кэш, Вложение, ИмяСтороны) Экспорт
	
	Попытка
		Возврат Вложение.СтруктураДокумента.Файл.Документ.Стороны[ИмяСтороны];	
	Исключение
		Возврат Неопределено;
	КонецПопытки;
	
КонецФункции

&НаКлиенте
Функция ИсточникДанных_ПолучитьТабличнуюЧастьДокумента(Кэш, Вложение, ИмяТабличнойЧасти) Экспорт
	
	Попытка
		Возврат Вложение.СтруктураДокумента.Файл.Документ.СписокСтрТабл[ИмяТабличнойЧасти];
	Исключение
		Возврат Неопределено;
	КонецПопытки;
	
КонецФункции

&НаКлиенте
Функция ИсточникДанных_ПолучитьСтранаПроизводства(Кэш, Источник) Экспорт
	
	Попытка
		Возврат Новый Структура("КодСтраныПроизводства, СтранаПроизводства", Источник.Производитель.Код, Источник.Производитель.Страна);
	Исключение
		Возврат Неопределено;
	КонецПопытки;
	
КонецФункции

&НаКлиенте
Функция ИсточникДанных_ИтогТабл(Кэш, Вложение) Экспорт
	
	Попытка
		ИтогТабл = Вложение.СтруктураДокумента.Файл.Документ.СписокСтрТабл.ИтогТабл;
		Возврат Новый Структура("СтруктураИтоги, ИмяТабл", ИтогТабл[0], "ИтогТабл");
	Исключение
		Возврат Неопределено;
	КонецПопытки;
	
КонецФункции

&НаКлиенте
Функция СформироватьДокументДляГенератора(Кэш, Док, Контекст, Вложение) Экспорт
	
	Если НЕ Кэш.ОбщиеФункции.ГенераторВключенДляДокумента(Кэш, Контекст.ФайлДанные) Тогда
		Возврат Док;
	КонецЕсли;
	
	ТекДокумент = Док.Файл.Документ;
	
	Если НЕ ТекДокумент.Стороны.Свойство("Получатель") Тогда
		ТекДокумент.Стороны.Вставить("Получатель", Новый Структура());
		Кэш.ОбщиеФункции.сбисСкопироватьСтруктуруНаКлиенте(ТекДокумент.Стороны.Получатель, Вложение.Получатель);
	КонецЕсли;
	Если НЕ ТекДокумент.Стороны.Свойство("Отправитель") Тогда
		ТекДокумент.Стороны.Вставить("Отправитель", Новый Структура());
		Кэш.ОбщиеФункции.сбисСкопироватьСтруктуруНаКлиенте(ТекДокумент.Стороны.Отправитель, Вложение.Отправитель);
	КонецЕсли;
	Если НЕ ЗначениеЗаполнено(ТекДокумент.Стороны.Получатель.GLN) Тогда
		ТекДокумент.Стороны.Получатель.GLN = Вложение.Получатель.GLN;	
	КонецЕсли;
	Если НЕ ЗначениеЗаполнено(ТекДокумент.Стороны.Отправитель.GLN) Тогда
		ТекДокумент.Стороны.Отправитель.GLN = Вложение.Отправитель.GLN;	
	КонецЕсли;
	
	Для Каждого ТекСтрока ИЗ ТекДокумент.СписокСтрТабл.СтрТабл Цикл
		ЗаполнитьПоСтрТаблПараметр(Кэш, ТекСтрока);
		СформироватьИнфПол(Кэш, ТекСтрока);
		РасчитатьЦенуСНДС(Кэш, ТекСтрока);
		
	КонецЦикла;
	
	СформироватьОснование(Кэш, ТекДокумент);
	СформироватьПараметры(Кэш, ТекДокумент);
	
	Возврат Док;
	
КонецФункции

&НаКлиенте
Процедура ЗаполнитьПоСтрТаблПараметр(Кэш, ТекСтрока)
	
	Если НЕ (ТекСтрока.Свойство("СписокПараметр") И ТекСтрока.СписокПараметр.Свойство("Параметр")) Тогда
		Возврат;		
	КонецЕсли;
	
	Для Каждого ТекПараметр ИЗ ТекСтрока.СписокПараметр.Параметр Цикл
		
		Если ТекПараметр.Имя = "НомерГТД" Тогда
			ТекСтрока.Вставить("ГТД", СокрЛП(ТекПараметр.Значение));
			Прервать;
		КонецЕсли;
		
	КонецЦикла

КонецПроцедуры

&НаКлиенте
Процедура СформироватьИнфПол(Кэш, ТекСтрока)
	
	ИнфПол = Новый Массив;
	
	Для Каждого Текущий ИЗ ТекСтрока Цикл
		Если Текущий.Ключ = "GTIN" Тогда
			ИнфПол.Добавить(Новый Структура("Имя, Значение", "GTIN", Текущий.Значение));
			Прервать;
		КонецЕсли;
	КонецЦикла;
	
	Если ТекСтрока.Свойство("СписокПараметр") И ТекСтрока.СписокПараметр.Свойство("Параметр") Тогда
		Исключения = ПолучитьИсключенияИнфПол();
		Для Каждого ТекПараметр ИЗ ТекСтрока.СписокПараметр.Параметр Цикл
			
			Если Исключения.Получить(ТекПараметр.Имя) = Истина Тогда
				Продолжить;	
			КонецЕсли;
			
			ИнфПол.Добавить(Новый Структура("Имя, Значение", ТекПараметр.Имя, ТекПараметр.Значение));
			
		КонецЦикла;
	КонецЕсли;
	
	ИнфПол = ПолучитьПараметрыБезПустыхЗаписей(Кэш, ИнфПол);
	
	Если ИнфПол.Количество() <> 0 Тогда
		ТекСтрока.Вставить("ИнфПол", ИнфПол);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Функция ПолучитьИсключенияИнфПол()
	
	ИсключенияИнфПол = Новый Соответствие;
	ИсключенияИнфПол.Вставить("ИдГосКон", Истина);
	ИсключенияИнфПол.Вставить("СвТранГруз", Истина);
	ИсключенияИнфПол.Вставить("ДатаПер", Истина);
	ИсключенияИнфПол.Вставить("РабОргПрод_Должность", Истина);
	ИсключенияИнфПол.Вставить("РабОргПрод_ФИО", Истина);
	ИсключенияИнфПол.Вставить("ИнЛицо_Должность", Истина);
	ИсключенияИнфПол.Вставить("ИнЛицо_ФИО", Истина);
	ИсключенияИнфПол.Вставить("ИнЛицо_НаимОргПер", Истина);
	ИсключенияИнфПол.Вставить("СвПерВещ", Истина);
	ИсключенияИнфПол.Вставить("НомерГТД", Истина);
	
	Возврат ИсключенияИнфПол;
	
КонецФункции

&НаКлиенте
Процедура РасчитатьЦенуСНДС(Кэш, ТекСтрока)
	
	Попытка
		СуммаСНДС = Число(ТекСтрока.Сумма);
	Исключение
		Возврат;
	КонецПопытки;
	
	Попытка
		Количество = Число(ТекСтрока.Кол_во);
	Исключение
		Возврат;
	КонецПопытки;
	
	Попытка
		ЦенаСНДС = СуммаСНДС / Количество;	
	Исключение
		Возврат;
	КонецПопытки;
	
	ТекСтрока.Вставить("ЦенаСНДС", Формат(ЦенаСНДС, "ЧДЦ=2; ЧРД=.; ЧН=0.00; ЧГ="));
	
КонецПроцедуры

&НаКлиенте
Процедура СформироватьОснование(Кэш, ТекДокумент)
	
	Если НЕ (ТекДокумент.Свойство("СписокОснование") И ТекДокумент.СписокОснование.Свойство("Основание")) Тогда
		Возврат;
	КонецЕсли;
	
	Исключения = ПолучитьИсключенияОснование();
	
	ОснованиеМассив = Новый Массив;
	
	Для Каждого ТекСтрока ИЗ ТекДокумент.СписокОснование.Основание Цикл
		
		Если ТекСтрока.Свойство("Тип") Тогда
			Ключ = "Тип";	
		Иначе
			Ключ = "Название";	
		КонецЕсли;
		
		Если Исключения.Получить(ТекСтрока[Ключ]) = Истина Тогда
			Продолжить;	
		КонецЕсли;
		
		Если НЕ ЗначениеЗаполнено(ТекСтрока[Ключ]) Тогда
			Продолжить;	
		КонецЕсли;
		
		Если НЕ ЗначениеЗаполнено(ТекСтрока.Дата) Тогда
			Продолжить;	
		КонецЕсли; 
		
		Основание = Новый Структура("Номер, Название, Дата");
		Основание.Название 	= ТекСтрока[Ключ];
		Основание.Номер 	= ТекСтрока.Номер;
		Основание.Дата 		= ТекСтрока.Дата;
		
		ОснованиеМассив.Добавить(Основание);
		
	КонецЦикла;
	
	Если ОснованиеМассив.Количество() <> 0 Тогда
		ТекДокумент.Вставить("Основание", ОснованиеМассив);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Функция ПолучитьИсключенияОснование()
	
	ИсключенияИнфПол = Новый Соответствие;
	ИсключенияИнфПол.Вставить("ПРД", Истина);
	ИсключенияИнфПол.Вставить("СчФ", Истина);
	ИсключенияИнфПол.Вставить("КСчФ", Истина);
	ИсключенияИнфПол.Вставить("ИспрСчФ", Истина);
	ИсключенияИнфПол.Вставить("ИсхСчФ", Истина);
	ИсключенияИнфПол.Вставить("ИспрИсхСчФ", Истина);
	ИсключенияИнфПол.Вставить("ДокПодтвОтгр", Истина);
	
	Возврат ИсключенияИнфПол;
	
КонецФункции

&НаКлиенте
Процедура СформироватьПараметры(Кэш, ТекДокумент) 
	
	Если НЕ (ТекДокумент.Свойство("СписокПараметр") И ТекДокумент.СписокПараметр.Свойство("Параметр")) Тогда
		Возврат;
	КонецЕсли;
	
	мПараметры = ТекДокумент.СписокПараметр.Параметр;
	
	ДобавитьСведенияGLNПоИмениСтороны(Кэш, ТекДокумент, "Получатель", мПараметры, "GLNПокуп");
	ДобавитьСведенияGLNПоИмениСтороны(Кэш, ТекДокумент, "Грузополучатель", мПараметры, "GLNГрузПолуч");
	ДобавитьСведенияGLNПоИмениСтороны(Кэш, ТекДокумент, "Отправитель", мПараметры, "GLNПост");
	ДобавитьСведенияGLNПоИмениСтороны(Кэш, ТекДокумент, "Грузоотправитель", мПараметры, "GLNГрузОтпр");
	
	мПараметры = ПолучитьПараметрыБезПустыхЗаписей(Кэш, мПараметры);
	
	Если мПараметры.Количество() <> 0 Тогда
		ТекДокумент.Вставить("Параметры", мПараметры);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьСведенияGLNПоИмениСтороны(Кэш, ТекДокумент, ИмяСтороны, МассивПараметров, Ключ)
	
	Если НЕ ТекДокумент.Стороны.Свойство(ИмяСтороны) Тогда
		Возврат;	
	КонецЕсли;
	
	Данные = ТекДокумент.Стороны[ИмяСтороны];
	Если НЕ Данные.Свойство("GLN") Тогда
		Возврат;	
	КонецЕсли;
	
	МассивПараметров.Добавить(Новый Структура("Имя, Значение", Ключ, Данные.GLN));
	
КонецПроцедуры

&НаКлиенте
Функция ПолучитьПараметрыБезПустыхЗаписей(Кэш, МассивПараметров)
	
	МассивПараметровИсходящий = Новый Массив;
	
	Для Каждого ТекСтрока ИЗ МассивПараметров Цикл
		
		Если НЕ ТекСтрока.Свойство("Имя") ИЛИ НЕ ТекСтрока.Свойство("Значение") Тогда
			Продолжить;	
		КонецЕсли;
		
		Если НЕ ЗначениеЗаполнено(ТекСтрока.Значение) Тогда
			Продолжить;	
		КонецЕсли;
		
		МассивПараметровИсходящий.Добавить(Новый Структура("Имя, Значение", ТекСтрока.Имя, ТекСтрока.Значение));
		
	КонецЦикла;
	
	Возврат МассивПараметровИсходящий;
	
КонецФункции
//}