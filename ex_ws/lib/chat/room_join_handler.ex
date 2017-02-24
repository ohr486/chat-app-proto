defmodule Chat.RoomJoinHandler do
  def init(req, opts) do
    headers = %{"content-type" => "text/html"}
    resp_body = build_body(req.bindings[:room_id])
    {:ok, resp} = :cowboy_req.reply(200, headers, resp_body, req)
    {:ok, resp, opts}
  end

  def build_body(room_id) do
    """
    <html lang='ja'>
      <head>
        <meta charset='utf-8'/>
        <script src='http://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js'></script>
        <title>Elixir-Websocket</title>
        <style>
          input { display: block; }
          ul { list-style: none; }
        </style>
      </head>
      <body>
        #{room_id}
        <form id='chatbox'>
          <textarea></textarea>
          <input type='submit' value='送信' />
        </form>
        <ul id='messages'></ul>
        <script>
          $(function(){
            var socket = null;
            var msgBox = $('#chatbox textarea');
            var messages = $('#messages');
            $('#chatbox').submit(function(){
              if (!msgBox.val()) return false;
              if (!socket) {
                alert('エラー: WebSocket接続が行われていません。');
                return false;
              }
              socket.send(msgBox.val());
              msgBox.val('');
              return false;
            });
            if (!window['WebSocket']) {
              alert('エラー: WebSocketに対応していないブラウザです。')
            } else {
              socket = new WebSocket('ws://localhost:4000/websocket/#{room_id}');
              socket.onmessage = function(e) {
                messages.append($('<li>').text(e.data));
              }
            }
          });
        </script>
      </body>
    </html>
    """
  end
end
