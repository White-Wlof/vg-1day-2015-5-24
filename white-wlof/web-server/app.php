<?php

use Symfony\Component\HttpFoundation\Request;

$app = new My1DayServer\Application();
$app['debug'] = true;

$app->get('/messages', function () use ($app) {
    $messages = $app->getAllMessages();

    return $app->json($messages);
});

$app->get('/messages/{id}', function ($id) use ($app) {
    $message = $app->getMessage($id);

    return $app->json($message);
});

$app->post('/messages', function (Request $request) use ($app) {
    $data = $app->validateRequestAsJson($request);

    $username = isset($data['username']) ? $data['username'] : '';
    $body = isset($data['body']) ? $data['body'] : '';
    switch($i=rand(0,2)){
         case 0:
            $uranai = "kichi";
            break;
         case 1:
            $uranai = "kyou";
            break;
         case 2:
            $uranai = "daikichi";
            break;
         default:
            break;
    }
    $createdMessage = $app->createMessage($username, $body, base64_encode(file_get_contents($app['icon_image_path'])));
    $createdMessage = $app->createMessage("Bot", $body, base64_encode(file_get_contents($app['icon_image_path'])), $uranai);

    return $app->json($createdMessage);
});

return $app;
