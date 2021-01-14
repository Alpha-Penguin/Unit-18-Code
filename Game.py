#imports (standard flask and mysqlconnector)
from flask import Flask, render_template, request
import mysql.connector

app = Flask(__name__)

#connecting to local database. This is obvs terrible security. ( discussed as part of lead in to U7)
gamedb = mysql.connector.connect(user='Gamemaster', password='Journeygame14',
                            host='127.0.0.1', database='journey_to_cariryn',
                            auth_plugin='mysql_native_password')



@app.route('/', methods=['GET', 'POST'])
def index():

    if "addplayer" in request.form:
        return render_template('/addplayer.html', data1 = getrace(), data2 = getclass(), data3 = getalignment(), data4 = getarmour())
    elif "viewinventory" in request.form:
        return render_template('/viewinventory.html',data=getplayer())
    elif "addencounter" in request.form:
        return render_template('addencounter.html', data1 = getlocation(), data2 = getnpc(), data3 = getenemy(), data4 = getitem())
    elif "viewallencounters" in request.form:
        return render_template('viewallencounters.html', data1 = viewallencounters(), data2 = getenemy()) 
    elif "addlocation" in request.form:
        return render_template('addlocation.html') 
    elif "viewnpc" in request.form:
        return render_template('/viewNPC.html', data=viewnpcs()) 
    elif "addnpc" in request.form:
        return render_template('addNPC.html') 
    elif "viewitems" in request.form:
        return render_template('/viewitems.html', data=viewitems())
    elif "additem" in request.form:
        return render_template('additem.html', data=getitemtype()) 
    else:
        return render_template('/index.html')



#Code runs if adding a new owner (submit pressed on addplayer.html page)
@app.route('/player', methods=['GET', 'POST'])
def player():
  #Takes details from form and crafts a sql statement         
  if "submit" in request.form:
          details = request.form
          First_Name = details['First Name']
          Last_Name = details['Last Name']
          RaceID = getraceid(details['Race'])
          ClassID = getclassid(details['Class'])
          AlignmentID = getalignmentid(details['Alignment'])
          Int_RaceID = RaceID[0]
          Int_RaceID = int(Int_RaceID[0])
          Int_ClassID = ClassID[0]
          Int_ClassID = int(Int_ClassID[0])
          Int_AlignmentID = AlignmentID[0]
          Int_AlignmentID = int(Int_AlignmentID[0])

          Level = details['level']
          Strength = details['strength']
          Brawn = details['brawn']
          Agility = details['agility']
          Mettle = details['mettle']
          Craft = details['craft']
          Insight = details['insight']

          Wits = details['wits']
          Resolve = details['resolve']
          Life = details['life']

          ArmourID = getarmourid(details['Armour'])
          Int_ArmourID = ArmourID[0]
          Int_ArmourID = int(Int_ArmourID[0])

          Shield = details['Shield']
          Helm = details['Helm']

          cur = gamedb.cursor()
          cur.execute("INSERT INTO pc(`First Name`, `Last Name`, RaceID, ClassID, AlignmentID, Level, Strength, Brawn, Agility, Mettle, Craft, Insight, Wits, Resolve, Life, ArmourID, Shield, Helm) VALUES (%s, %s,%s,%s,%s, %s,%s,%s,%s, %s,%s,%s,%s, %s,%s,%s,%s, %s)", (First_Name, Last_Name, Int_RaceID,Int_ClassID, Int_AlignmentID, Level, Strength, Brawn, Agility, Mettle, Craft, Insight, Wits, Resolve, Life, Int_ArmourID, Shield, Helm ))
          gamedb.commit()
          cur.close()      
  elif "cancel" in request.form:
        pass
  return render_template('/index.html')


#viewinventory
@app.route('/view inventory', methods=['GET', 'POST'])
def viewinventory():
  #Takes details from form and crafts a sql statement         
  if "submit" in request.form:
      details = request.form
      PlayerID = getplayerid(details['Player'])
      Int_PlayerID = PlayerID[0]
      Int_PlayerID = str(Int_PlayerID[0])  
      return render_template('/modify inventory.html',data =getinventory(Int_PlayerID), data2 = getsum(Int_PlayerID), data3 = Int_PlayerID,data4=getplayer(), data5 = getitem())      
  elif "cancel" in request.form:
        pass
  return render_template('/index.html')

@app.route('/modify inventory', methods=['GET', 'POST'])
def modifyinventory():
  #Takes details from form and crafts a sql statement         
  if "submit" in request.form:
      details = request.form
      InventoryID = details['Remove']
      cur = gamedb.cursor()
      sql = "DELETE FROM inventory where inventory.InventoryID = %s"
      nq = InventoryID
      cur.execute(sql,(nq,))
      gamedb.commit()
      cur.close()   
      return render_template('/viewinventory.html',data=getplayer()) 
  if "add" in request.form:
      details = request.form 
      PlayerID = getplayerid(details['Player']) 
      Int_PlayerID = PlayerID[0]
      Int_PlayerID = int(Int_PlayerID[0])  
      ItemID = getitemid(details['Item']) 
      Int_ItemID = ItemID[0]
      Int_ItemID = int(Int_ItemID[0])
      cur = gamedb.cursor()
      cur.execute("INSERT INTO inventory(PlayerID, ItemID) VALUES (%s, %s)", (Int_PlayerID, Int_ItemID))
      gamedb.commit()
      cur.close()      
  elif "cancel" in request.form:
        pass
  return render_template('/index.html')


@app.route('/add encounter', methods=['GET', 'POST'])
def addencounter():
  #Takes details from form and crafts a sql statement         
  if "add" in request.form:
      details = request.form 
      LocationID = getlocationid(details['location']) 
      Int_LocationID = LocationID[0]
      Int_LocationID = int(Int_LocationID[0]) 
      NPCID = getnpcid(details['npc']) 
      Int_NPCID = NPCID[0]
      Int_NPCID = int(Int_NPCID[0])  
      EnemyID = getenemyid(details['enemy']) 
      Int_EnemyID = EnemyID[0]
      Int_EnemyID = int(Int_EnemyID[0])   
      ItemID = getitemid(details['item']) 
      Int_ItemID = ItemID[0]
      Int_ItemID = int(Int_ItemID[0])
      cur = gamedb.cursor()
      cur.execute("INSERT INTO encounter(LocationID, NPCID, EnemyID, ItemID) VALUES (%s, %s, %s, %s )", (Int_LocationID, Int_NPCID,Int_EnemyID, Int_ItemID))
      gamedb.commit()
      cur.close()      
  elif "cancel" in request.form:
        pass
  return render_template('/index.html')




@app.route('/add item', methods=['GET', 'POST'])
def additem():
  #Takes details from form and crafts a sql statement         
  if "submit" in request.form:
      details = request.form
      Name = details['Name']
      Cost = details['cost']
      Load = details['load']
      ItemTypeID = getitemtypeid(details['itemtype'])
      Int_ItemTypeID = ItemTypeID[0]
      Int_ItemTypeID = int(Int_ItemTypeID[0])  
      cur = gamedb.cursor()
      cur.execute("INSERT INTO items(Name, Cost, `Load`, ItemTypeID) VALUES (%s, %s, %s, %s)", (Name, Cost, Load, Int_ItemTypeID))
      gamedb.commit()
      cur.close()        
  elif "cancel" in request.form:
        pass
  return render_template('/index.html')




@app.route('/location', methods=['GET', 'POST'])
def addlocation():
  #Takes details from form and crafts a sql statement         
  if "submit" in request.form:
      details = request.form
      Name = details['Name']
      Description = details['Description']
      cur = gamedb.cursor()
      cur.execute("INSERT INTO location(Name, Description) VALUES (%s, %s)", (Name, Description))
      gamedb.commit()
      cur.close()        
  elif "cancel" in request.form:
        pass
  return render_template('/index.html')


@app.route('/add NPC', methods=['GET', 'POST'])
def addnpc():
  #Takes details from form and crafts a sql statement         
  if "submit" in request.form:
      details = request.form
      Name = details['Name']
      Strength = details['strength']
      Craft = details['craft']
      Life = details['life']
      cur = gamedb.cursor()
      cur.execute("INSERT INTO npc(Name, Strength, Craft, Life) VALUES (%s, %s,%s,%s)", (Name, Strength, Craft, Life))
      gamedb.commit()
      cur.close()    
  elif "cancel" in request.form:
        pass
  return render_template('/index.html')

#viewinventory
@app.route('/view all encounters', methods=['GET', 'POST'])
def viewallencounter():
  #Takes details from form and crafts a sql statement         
  if "submit" in request.form:
      details = request.form
      Enemy = details['enemy']
      return render_template('/viewsortencounters.html',data1 = viewsortencounters(Enemy), data2 = getenemy())      
  elif "cancel" in request.form:
        pass
  return render_template('/index.html')

@app.route('/view sorted encounters', methods=['GET', 'POST'])
def viewsortedencounter():
  #Takes details from form and crafts a sql statement         
  if "submit" in request.form:
      details = request.form
      Enemy = details['enemy']
      return render_template('/viewsortencounters.html',data1 = viewsortencounters(Enemy), data2 = getenemy())      
  elif "cancel" in request.form:
        pass
  return render_template('/index.html')


def getrace():
    cur = gamedb.cursor()
    cur.execute("Select Name FROM race")
    data = cur.fetchall()
    return data

def getclass():
    cur = gamedb.cursor()
    cur.execute("Select ClassName FROM class")
    data = cur.fetchall()
    return data

def getalignment():
    cur = gamedb.cursor()
    cur.execute("Select AlignmentType FROM alignment")
    data = cur.fetchall()
    return data

def getarmour():
    cur = gamedb.cursor()
    cur.execute("Select Name FROM armour")
    data = cur.fetchall()
    return data


def viewnpcs():
    cur = gamedb.cursor()
    cur.execute("SELECT Name, Strength, Craft, Life FROM npc")
    data = cur.fetchall()
    return data

def viewitems():
    cur = gamedb.cursor()
    cur.execute("SELECT items.Name, Cost, items.Load, itemtype.Name FROM items, itemtype where items.ItemtypeID = itemtype.ItemTypeID ORDER by Cost Desc;")
    data = cur.fetchall()
    return data

def viewallencounters():
    cur = gamedb.cursor()
    cur.execute("SELECT EncounterID, location.Name, npc.Name, enemy.Name, items.Name FROM location, npc,enemy,items,encounter where location.LocationID = encounter.LocationID and npc.NPCID = encounter.NPCID and enemy.EnemyID = encounter.EnemyID and items.ItemID = encounter.ItemID;")
    data = cur.fetchall()
    return data

def viewsortencounters(name):
    cur = gamedb.cursor()
    cur.execute("SELECT EncounterID, location.Name, npc.Name, enemy.Name, items.Name FROM location, npc,enemy,items,encounter where encounter.EnemyID = enemy.EnemyID and location.LocationID = encounter.LocationID and npc.NPCID = encounter.NPCID and enemy.EnemyID = encounter.EnemyID and items.ItemID = encounter.ItemID and enemy.Name = '"+name+"'")
    data = cur.fetchall()
    return data

def getplayer():
    cur = gamedb.cursor()
    cur.execute("Select `First Name` FROM pc")
    data = cur.fetchall()
    return data


def getlocation():
    cur = gamedb.cursor()
    cur.execute("Select Name FROM location")
    data = cur.fetchall()
    return data

def getenemy():
    cur = gamedb.cursor()
    cur.execute("Select Name FROM enemy")
    data = cur.fetchall()
    return data

def getnpc():
    cur = gamedb.cursor()
    cur.execute("Select Name FROM npc")
    data = cur.fetchall()
    return data

def getitem():
    cur = gamedb.cursor()
    cur.execute("Select Name FROM items")
    data = cur.fetchall()
    return data

def getitemtype():
    cur = gamedb.cursor()
    cur.execute("Select Name FROM itemtype")
    data = cur.fetchall()
    return data

def getraceid(name):
    cur = gamedb.cursor()
    query = ("Select RaceID FROM race where Name='"+name+"'")
    cur.execute(query)
    data = cur.fetchall()
    return data

def getclassid(name):
    cur = gamedb.cursor()
    query = ("Select ClassID FROM class where ClassName='"+name+"'")
    cur.execute(query)
    data = cur.fetchall()
    return data

def getalignmentid(name):
    cur = gamedb.cursor()
    query = ("Select AlignmentID FROM alignment where AlignmentType='"+name+"'")
    cur.execute(query)
    data = cur.fetchall()
    return data

def getarmourid(name):
    cur = gamedb.cursor()
    query = ("Select ArmourID FROM armour where Name='"+name+"'")
    cur.execute(query)
    data = cur.fetchall()
    return data

def getplayerid(name):
    cur = gamedb.cursor()
    query = ("Select PlayerID FROM pc where `First Name`='"+name+"'")
    cur.execute(query)
    data = cur.fetchall()
    return data

def getitemid(name):
    cur = gamedb.cursor()
    query = ("Select ItemID FROM items where `Name`='"+name+"'")
    cur.execute(query)
    data = cur.fetchall()
    return data

def getlocationid(name):
    cur = gamedb.cursor()
    query = ("Select LocationID FROM location where `Name`='"+name+"'")
    cur.execute(query)
    data = cur.fetchall()
    return data

def getnpcid(name):
    cur = gamedb.cursor()
    query = ("Select NPCID FROM npc where `Name`='"+name+"'")
    cur.execute(query)
    data = cur.fetchall()
    return data

def getenemyid(name):
    cur = gamedb.cursor()
    query = ("Select EnemyID FROM enemy where `Name`='"+name+"'")
    cur.execute(query)
    data = cur.fetchall()
    return data

def getitemtypeid(name):
    cur = gamedb.cursor()
    query = ("Select ItemTypeID FROM itemtype where `Name`='"+name+"'")
    cur.execute(query)
    data = cur.fetchall()
    return data



def getinventory(name):
    cur = gamedb.cursor()
    query=("SELECT InventoryID, items.Name, Cost, items.Load, itemtype.Name FROM journey_to_cariryn.inventory, items, itemtype where PlayerID = '"+name+"' and inventory.ItemID = items.ItemID     and     items.ItemtypeID = itemtype.ItemTypeID")
    cur.execute(query)
    data = cur.fetchall()
    return data

def getsum(name):
    cur = gamedb.cursor()
    query=("Select sum(`Load`) from journey_to_cariryn.inventory, items, itemtype where PlayerID = '"+name+"' and inventory.ItemID = items.ItemID     and     items.ItemtypeID = itemtype.ItemTypeID")
    cur.execute(query)
    data = cur.fetchall()
    return data


  



#Select InventoryID, PlayerID, ItemID FROM inventory where PlayerID = '"+name+"'"

if __name__ == '__main__':
    app.run(debug=True)
    #app.run()
