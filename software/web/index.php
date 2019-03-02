<!DOCTYPE HTML>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>Zobrazovač EKG</title>
  <link rel="stylesheet" href="//stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
  <link rel="stylesheet" href="//use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
  <link rel="stylesheet" href="/style/cover.css">
  <link rel="stylesheet" href="/style/custom.css">
</head>
<body class="text-center">
  <div class="cover-container d-flex w-100 h-100 p-3 mx-auto flex-column">
    <header class="masthead mb-auto">
      <div class="inner">
        <h3 class="masthead-brand"><i class="fas fa-file-medical-alt"></i> Zobrazovač EKG</h3>
        <nav class="nav nav-masthead justify-content-center">
          <a class="nav-link active" href="/">Domov</a>
          <a class="nav-link" href="about.php">O projekte</a>
          <a class="nav-link" href="contact.php">Kontakt</a>
        </nav>
      </div>
    </header>
  
    <main role="main" class="inner cover">
      <?php
        if(isset($_GET['error'])) {
          echo "<div class=\"alert alert-danger\" role=\"alert\">Vyskytla sa chyba pri nahrávaní súboru. Uistite sa, že je formátu csv a nepresahuje veľkosť 2 MB.</div>";
        }
      ?>

      <div id="drop-zone" ondrop="dropHandler(event);" ondragover="dragOverHandler(event);">
        <h1 class="cover-heading">Nahrajte súbor</h1>
        <p class="lead">Jednoducho sem myšou pretiahnite súbor získaný zo zariadenia EKG. Vybrať si ho z počítača môžete aj kliknutím na tlačidlo nižšie.</p>
        <p class="lead">
          <form enctype="multipart/form-data" action="upload.php" method="post" id="upload-form">
            <input name="csv" type="file" id="inputfile" onchange="fileInputHandler(this);">
            <label for="inputfile" class="btn btn-lg btn-secondary">Vybrať súbor...</label>
          </form>
        </p>
      </div>
      
      <div id="chart-container" class="text-left">
        <div class="form-inline mb-4">
          <div class="form-group">
            <a href="/" class="btn btn-primary"><i class="fas fa-angle-left"></i> Naspäť</a>
          </div>
          <div class="input-group mx-3">
            <div class="input-group-prepend">
              <div class="input-group-text"><i class="fas fa-link"></i></div>
            </div>
            <input type="text" class="form-control" id="url-bar" onclick="this.select();">
          </div>
        </div>
        <div id="graph"></div>
      </div>
      
    </main>
  
    <footer class="mastfoot mt-auto">
      <div class="inner">
        <p>&copy; 2019. Stránka je súčasťou <a href="https://github.com/andraszemes/one-lead-ecg" target="_blank">maturitnej práce</a>
            Andrása Zemesa.</p>
      </div>
    </footer>
  </div>

  <script type="text/javascript" src="//canvasjs.com/assets/script/jquery-1.11.1.min.js"></script>
  <script type="text/javascript" src="//canvasjs.com/assets/script/canvasjs.min.js"></script>
  <script type="text/javascript" src="/script/script.js"></script>
</body>
</html>                              