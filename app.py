from flask import Flask, render_template, request, redirect, url_for, flash, jsonify
import mysql.connector

app = Flask(__name__)
app.secret_key = 'supersecretkey'

# Configurații bazei de date
db_config = {
    'user': 'root',
    'password': 'Pass_3316',
    'host': 'localhost',
    'database': 'program'
}

# Funcție pentru conectarea la baza de date
def connect_to_database():
    return mysql.connector.connect(**db_config)

# Funcție pentru a obține datele dintr-o tabelă
def get_data(query):
    connection = connect_to_database()
    cursor = connection.cursor(dictionary=True)
    cursor.execute(query)
    data = cursor.fetchall()
    cursor.close()
    connection.close()
    return data

# Pagina principală
@app.route('/')
def index():
    clienti = get_data("SELECT * FROM clienti")
    filme = get_data("SELECT * FROM film")
    seriale = get_data("SELECT * FROM seriale")
    success_message = request.args.get('success_message')
    return render_template('index.html', clienti=clienti, filme=filme, seriale=seriale, success_message=success_message)

# Ruta pentru adăugarea unui client nou
@app.route('/adauga_client', methods=['POST'])
def adauga_client():
    cod_client = request.form['cod_client']
    nume = request.form['nume']
    prenume = request.form['prenume']
    data_nastere = request.form['data_nastere']
    email = request.form['email']

    connection = connect_to_database()
    cursor = connection.cursor()

    try:
        cursor.execute("INSERT INTO clienti (cod_clienti, nume, prenume, data_nastere, email) VALUES (%s, %s, %s, %s, %s)", 
                       (cod_client, nume, prenume, data_nastere, email))
        connection.commit()
        flash('Clientul a fost adăugat cu succes!', 'success')
    except mysql.connector.Error as err:
        flash(f'Eroare la adăugarea clientului: {err}', 'danger')
    finally:
        cursor.close()
        connection.close()
    return redirect(url_for('index'))

# Ruta pentru ștergerea unui client
@app.route('/sterge_client', methods=['POST'])
def sterge_client():
    cod_client = request.form['cod_client']

    connection = connect_to_database()
    cursor = connection.cursor()

    try:
        # Ștergere înregistrări dependente din tabelul cont
        cursor.execute("DELETE FROM cont WHERE cod_clienti = %s", (cod_client,))
        connection.commit()

        # Ștergere client din tabelul clienti
        cursor.execute("DELETE FROM clienti WHERE cod_clienti = %s", (cod_client,))
        connection.commit()

        flash('Clientul a fost șters cu succes!', 'success')
    except mysql.connector.Error as err:
        flash(f'Eroare la ștergerea clientului: {err}', 'danger')
    finally:
        cursor.close()
        connection.close()
    return redirect(url_for('index'))

# Ruta pentru obținerea datelor din tabelul clienti
@app.route('/get_clienti', methods=['GET'])
def get_clienti():
    clienti = get_data("SELECT * FROM clienti")
    return jsonify({"data": clienti})



# Rute pentru interogări intra-tabel și inter-tabele
@app.route('/query1')
def query1():
    result = get_data( "SELECT * FROM clienti WHERE data_nastere > '2000-01-01' AND email LIKE '%example%'")

    return render_template('index.html', query_result=result, query_title="Clienți născuți după 2000 si au in e-mail cuvantul 'example' (intra-tabel)")

@app.route('/query2')
def query2():
    result = get_data("SELECT * FROM film WHERE durata > 120")
    return render_template('index.html', query_result=result, query_title="Filme cu durata mai mare de 120 minute (intra-tabel)")

@app.route('/query3')
def query3():
    result = get_data("SELECT nume_film FROM film WHERE data_lansare>'1980-08-01' AND nume_film LIKE 'S%'")
    return render_template('index.html', query_result=result, query_title="Filme aparute dupa 01-08-1980 care incep cu S (intra-tabel)")

@app.route('/query4')
def query4():
    result = get_data("SELECT * FROM seriale WHERE nr_sezoane > 2")
    return render_template('index.html', query_result=result, query_title="Seriale cu mai mult de 2 sezoane (intra-tabel)")

@app.route('/query5')
def query5():
    result = get_data("SELECT nume_film FROM film WHERE id_categorie = '1' AND regizor = 'Michael Bay'")
    return render_template('index.html', query_result=result, query_title="Filme din categoria actiune cu regizorul Michael Bay (intra-tabel)")


@app.route('/query6')
def query6():
    result = get_data("  SELECT s.nume_serial, sz.actori, sz.data_lansare FROM seriale s JOIN sezon sz ON s.id_serial = sz.id_serial WHERE sz.nr_sezon = 1 AND s.lansare_initiale > '2022-01-01'")
    return render_template('index.html', query_result=result, query_title="Selectarea serialelor și actorilor din primul sezon al unui serial lansat după  01-01-2022 (inter-tabele)")

@app.route('/query7')
def query7():
    result = get_data("SELECT nume_film AS Nume_Articol FROM film WHERE id_categorie = 2 UNION SELECT nume_serial AS Nume_Articol FROM seriale WHERE id_categorie = 2")
    return render_template('index.html', query_result=result, query_title="Selectarea filmelor si serialelor de Animatie (inter-tabele)")

@app.route('/query8')
def query8():
    result = get_data("SELECT nume, prenume FROM clienti WHERE cod_clienti IN ( SELECT DISTINCT cod_clienti FROM cont JOIN categorie ON cont.id_cont = categorie.id_cont JOIN film ON categorie.id_categorie = film.id_categorie)")
    return render_template('index.html', query_result=result, query_title="Subinterogare care să obțină numele tuturor clientilor care au cel puțin un film înregistrat")

@app.route('/query9')
def query9():
    result = get_data("SELECT email, LENGTH(email) AS lungime_email FROM clienti")
    return render_template('index.html', query_result=result, query_title="Lungimea e-mail.ului (f. scalara)")


@app.route('/query10')
def query10():
    result = get_data("SELECT COUNT(*) AS numar_total_seriale FROM seriale")
    return render_template('index.html', query_result=result, query_title="Numarul total de seriale (f. agregat)")




if __name__ == '__main__':
    app.run(debug=True)