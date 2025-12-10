/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.luizfrancisco.estacionamento.dao;

import com.luizfrancisco.estacionamento.database.Conexao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.JOptionPane;

/**
 *
 * @author npc12
 */
public class UsuarioDAO {
// Método para autenticar o usuário e retornar o cargo/perfil
    public String autenticarUsuario(String email, char[] senha) {
        String cargo = null;
        String sql = "SELECT cargo FROM usuario WHERE email = ? AND senha = ?";
        
        // Converte o char[] para String para a comparação (lembre-se: idealmente use hash)
        String senhaString = new String(senha);

        try (Connection conn = Conexao.getConnection(); // Substitua 'suaClasseDeConexao' pela sua classe de fábrica
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            stmt.setString(2, senhaString); // CUIDADO: Em produção, use hash de senha!

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    // Usuário encontrado. Retorna o cargo dele.
                    cargo = rs.getString("cargo"); 
                }
            }

        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, "Erro ao tentar conectar com o banco de dados: " + e.getMessage());
            e.printStackTrace();
        }
        
        // Retorna null se não encontrar, ou o cargo se encontrar (ex: "Administrador")
        return cargo; 
    }

}
