<?php

session_start();

require('connect.php');

$sql_activities = "SELECT users.user_id as 'id', users.username as 'pseudo', categories.name as 'categorie', score.date_score as 'date', users.picture as 'pp' FROM users, categories, score WHERE users.user_id = score.user_id AND categories.id = score.categorie_id LIMIT 10";
$activities = $connect->prepare($sql_activities);
$activities->execute();
$activities = $activities->fetchAll();

$sql_news = "SELECT * FROM news LIMIT 3";
$news = $connect->prepare($sql_news);
$news->execute();
$news = $news->fetchAll();

if(isset($_SESSION['user'])){
    if(empty($_SESSION['user']["bio"]) || $_SESSION['user']['picture'] == "0.png"){
        $notification = "Completez votre profils, ajoutez une photo de profil ou une description !";
    }
}

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <base href="/blindtest/">
    <title>Accueil - Blindtest</title>
    <link rel="shortcut icon" href="asset/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <?php require_once "header.php"; ?>

    <?php require "notification.php"; ?>

    <div class="container">
        <div class="blur"></div>
        <div class="content">

            <div class="title">
                <h1>Blindtest</h1>
            </div>

            <main>

                <div class="home-activity">

                    <h2>Activité</h2>

                    <?php foreach($activities as $activity): ?>
                        <div class="activity">
                            <div class="activity-content">
                                <a href="user/<?= $activity["id"] ?>" class="user-profils">
                                    <img src="asset/profils_picture/<?= $activity["pp"] ?>" alt="Profil user">
                                </a>

                                <div class="user-activity">
                                    <p class="activity-details">
                                        <span class="activity-date">
                                            <?php

                                                $date = new DateTime($activity["date"]);
                                                $date = $date->format("d/m/Y à H:i");
                                                echo $date;

                                            ?>
                                        </span><br>
                                        <a href="user/<?= $activity["id"] ?>" class="activity-pseudo"><?= $activity["pseudo"] ?></a> a fait un blindtest sur les <a href="selection" class="activity-categorie"><?= ucfirst($activity["categorie"]) ?></a>.
                                    </p>
                                </div>
                            </div>
                        </div>
                    <?php endforeach; ?>

                </div>

                <div class="news">
                        
                    <h2>Nouveautés</h2>

                    <?php foreach($news as $new): ?>
                        <div class="new">
                            <p class="new-details">
                                <span class="new-version"><?= $new["version"] ?></span><br>
                                <span class="new-date">
                                    <?php

                                        $date = new DateTime($new["date"]);
                                        $date = $date->format("d/m/Y à H:i");
                                        echo $date;
                                    
                                    ?>
                                </span><br><br>
                                <?= $new["text"] ?>
                            </p>
                        </div>
                    <?php endforeach; ?>

                </div>

            </main>

        </div>
    </div>

    <?php require_once "footer.php"; ?>

    <script>
    </script>
    
</body>
</html>