package com.poc.support.controller;
import com.poc.support.model.ChatMessage;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
/*
* ChatController : Contrôleur responsable de gérer les messages de chat
*  intercepte les messages envoyés par les clients via WebSocket/STOMP
* et les retransmet à tous les abonnés */
@Controller
public class ChatController {

  @MessageMapping("/message")
  @SendTo("/chatroom/updates")
  public ChatMessage handleChatMessage(ChatMessage chatMessage) {
    return chatMessage;
  }
}
