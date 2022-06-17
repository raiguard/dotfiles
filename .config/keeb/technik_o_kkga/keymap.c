/* Copyright 2020 Boardsource
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include QMK_KEYBOARD_H

enum layers {
  _BASE,
  // _NAV,
  // _SYM,
  // _FUN,
};

// MOD TAPS
#define LCTL_Z MT(MOD_LCTL, KC_Z)
#define LALT_X MT(MOD_LALT, KC_X)
#define LSFT_C MT(MOD_LSFT, KC_C)
#define LGUI_V MT(MOD_LGUI, KC_V)
#define RGUI_M MT(MOD_RGUI, KC_M)
#define RSFT_COMM MT(MOD_RSFT, KC_COMM)
#define RALT_DOT MT(MOD_RALT, KC_DOT)
#define RCTL_SLSH MT(MOD_RCTL, KC_SLSH)

// COMBOS
const uint16_t PROGMEM ui_coln[] = {KC_U, KC_I, COMBO_END};
const uint16_t PROGMEM io_unds[] = {KC_I, KC_O, COMBO_END};
const uint16_t PROGMEM as_lcbr[] = {KC_A, KC_S, COMBO_END};
const uint16_t PROGMEM sd_lbrc[] = {KC_S, KC_D, COMBO_END};
const uint16_t PROGMEM df_lprn[] = {KC_D, KC_F, COMBO_END};
const uint16_t PROGMEM fg_labk[] = {KC_F, KC_G, COMBO_END};
const uint16_t PROGMEM hj_rabk[] = {KC_H, KC_J, COMBO_END};
const uint16_t PROGMEM jk_rprn[] = {KC_J, KC_K, COMBO_END};
const uint16_t PROGMEM kl_rbrc[] = {KC_K, KC_L, COMBO_END};
const uint16_t PROGMEM lscln_rcbr[] = {KC_L, KC_SCLN, COMBO_END};
const uint16_t PROGMEM mcomm_scln[] = {KC_M, KC_COMM, COMBO_END};
const uint16_t PROGMEM commdot_bsls[] = {KC_COMM, KC_DOT, COMBO_END};
const uint16_t PROGMEM dotslsh_ent[] = {KC_DOT, KC_SLSH, COMBO_END};
combo_t key_combos[COMBO_COUNT] = {
    COMBO(ui_coln, KC_COLN),
    COMBO(io_unds, KC_UNDS),
    COMBO(as_lcbr, KC_LCBR),
    COMBO(sd_lbrc, KC_LBRC),
    COMBO(df_lprn, KC_LPRN),
    COMBO(fg_labk, KC_LABK),
    COMBO(hj_rabk, KC_RABK),
    COMBO(jk_rprn, KC_RPRN),
    COMBO(kl_rbrc, KC_RBRC),
    COMBO(lscln_rcbr, KC_RCBR),
    COMBO(mcomm_scln, KC_SCLN),
    COMBO(commdot_bsls, KC_BSLS),
    COMBO(dotslsh_ent, KC_ENT)
};

// Keymap
const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
  [_BASE] = LAYOUT_ortho_4x12(
    KC_Q,   KC_W,    KC_E,    KC_R,    KC_T,   _______, _______, KC_Y,    KC_U,    KC_I,      KC_O,     KC_BSPC,
    KC_A,   KC_S,    KC_D,    KC_F,    KC_G,   _______, _______, KC_H,    KC_J,    KC_K,      KC_L,     KC_P,
    LCTL_Z, LALT_X,  LSFT_C,  LGUI_V,  KC_B,   _______, _______, KC_N,    RGUI_M,  RSFT_COMM, RALT_DOT, RCTL_SLSH,
    KC_ENT, _______, _______, _______, KC_SPC, _______, _______, KC_LSFT, _______, _______,   _______,  RESET
  ),
};
