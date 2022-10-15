object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 163
  Width = 254
  object dsCard: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'Fio'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'Birthday'
        DataType = ftDate
      end
      item
        Name = 'Gender'
        DataType = ftString
        Size = 7
      end
      item
        Name = 'Phone'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'WorkPlace'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Id'
        DataType = ftAutoInc
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 32
    Top = 16
    Data = {
      CC0000009619E0BD010000001800000006000000000003000000CC000346696F
      0100490000000100055749445448020002006400084269727468646179040006
      00000000000647656E6465720100490000000100055749445448020002000700
      0550686F6E65010049000000010005574944544802000200140009576F726B50
      6C61636501004900000001000557494454480200020014000249640400010000
      00010007535542545950450200490008004175746F696E630001000C4155544F
      494E4356414C55450400010001000000}
  end
end
