<?php
use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;
use Controllers\MainController as MC;
$app->get('/', function (Request $req, Response $res)
{
  return $res->withJson('Hello World');
});
$app->post('/registrar', function (Request $req, Response $res)
{
  $result = MC::add($req->getParsedBody());
  return $res->withJson($result);
});
$app->get('/preguntas', function (Request $req, Response $res)
{
  return $res->withJson(MC::getQuestions());
});
