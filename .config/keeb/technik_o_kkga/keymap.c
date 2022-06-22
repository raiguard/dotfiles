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
  _MSE,
  _GAME,
  _NAV,
  _SYM,
  _FUN,
};

// Layer toggles
#define MSE TG(_MSE)
#define GAME TG(_GAME)
#define NAV MO(_NAV)
#define SYM MO(_SYM)
#define FUN MO(_FUN)

// MOD TAPS
#define LCTL_Z MT(MOD_LCTL, KC_Z)
#define LALT_X MT(MOD_LALT, KC_X)
#define LSFT_C MT(MOD_LSFT, KC_C)
#define LGUI_C MT(MOD_LGUI, KC_C)
#define LGUI_V MT(MOD_LGUI, KC_V)
#define RGUI_M MT(MOD_RGUI, KC_M)
#define RSFT_COMM MT(MOD_RSFT, KC_COMM)
#define RALT_DOT MT(MOD_RALT, KC_DOT)
#define RCTL_SLSH MT(MOD_RCTL, KC_SLSH)
#define LCTL_ESC MT(MOD_LCTL, KC_ESC)
#define LALT_TAB MT(MOD_LALT, KC_TAB)

// COMBOS
const uint16_t PROGMEM qw_tab[] = {KC_Q, KC_W, COMBO_END};
const uint16_t PROGMEM er_dquo[] = {KC_E, KC_R, COMBO_END};
const uint16_t PROGMEM ui_coln[] = {KC_U, KC_I, COMBO_END};
const uint16_t PROGMEM io_unds[] = {KC_I, KC_O, COMBO_END};
const uint16_t PROGMEM as_esc[] = {KC_A, KC_S, COMBO_END};
const uint16_t PROGMEM sd_lbrc[] = {KC_S, KC_D, COMBO_END};
const uint16_t PROGMEM df_lprn[] = {KC_D, KC_F, COMBO_END};
const uint16_t PROGMEM fg_lcbr[] = {KC_F, KC_G, COMBO_END};
const uint16_t PROGMEM hj_rcbr[] = {KC_H, KC_J, COMBO_END};
const uint16_t PROGMEM jk_rprn[] = {KC_J, KC_K, COMBO_END};
const uint16_t PROGMEM kl_rbrc[] = {KC_K, KC_L, COMBO_END};
const uint16_t PROGMEM lp_ent[] = {KC_L, KC_P, COMBO_END};
const uint16_t PROGMEM cv_quot[] = {LSFT_C, LGUI_V, COMBO_END};
const uint16_t PROGMEM mcomm_scln[] = {RGUI_M, RSFT_COMM, COMBO_END};
const uint16_t PROGMEM commdot_bsls[] = {RSFT_COMM, RALT_DOT, COMBO_END};
combo_t key_combos[COMBO_COUNT] = {
    COMBO(qw_tab, KC_TAB),
    COMBO(er_dquo, KC_DQUO),
    COMBO(ui_coln, KC_COLN),
    COMBO(io_unds, KC_UNDS),
    COMBO(as_esc, KC_ESC),
    COMBO(sd_lbrc, KC_LBRC),
    COMBO(df_lprn, KC_LPRN),
    COMBO(fg_lcbr, KC_LCBR),
    COMBO(hj_rcbr, KC_RCBR),
    COMBO(jk_rprn, KC_RPRN),
    COMBO(kl_rbrc, KC_RBRC),
    COMBO(lp_ent, KC_ENT),
    COMBO(cv_quot, KC_QUOT),
    COMBO(mcomm_scln, KC_SCLN),
    COMBO(commdot_bsls, KC_BSLS),
};

// Keymap
const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
  [_BASE] = LAYOUT_ortho_4x12(
    KC_Q,    KC_W,    KC_E,    KC_R,   KC_T,   _______, _______, KC_Y,    KC_U,   KC_I,      KC_O,     KC_BSPC,
    KC_A,    KC_S,    KC_D,    KC_F,   KC_G,   _______, _______, KC_H,    KC_J,   KC_K,      KC_L,     KC_P,
    LCTL_Z,  LALT_X,  LSFT_C,  LGUI_V, KC_B,   _______, _______, KC_N,    RGUI_M, RSFT_COMM, RALT_DOT, RCTL_SLSH,
    _______, _______, _______, SYM,    KC_SPC, _______, _______, KC_LSFT, NAV,    _______,   _______,  RESET
  ),

  [_MSE] = LAYOUT_ortho_4x12(
    _______, _______, _______, _______, _______, _______, _______, KC_WH_L, KC_WH_D, KC_WH_U, KC_WH_R, _______,
    _______, _______, _______, _______, _______, _______, _______, KC_MS_L, KC_MS_D, KC_MS_U, KC_MS_R, KC_ACL2,
    _______, _______, _______, _______, _______, _______, _______, _______, KC_BTN3, _______, _______, _______,
    _______, _______, _______, _______, _______, _______, _______, KC_BTN1, KC_BTN2, _______, _______, _______
  ),

  [_GAME] = LAYOUT_ortho_4x12(
    LALT_TAB, KC_Q,    KC_W,    KC_E,   KC_R,   _______, _______, KC_T,    KC_Y, KC_U,    KC_I,    KC_BSPC,
    LCTL_ESC, KC_A,    KC_S,    KC_D,   KC_F,   _______, _______, KC_G,    KC_H, KC_J,    KC_K,    KC_L,
    KC_LSFT,  KC_Z,    KC_X,    LGUI_C, KC_V,   _______, _______, KC_B,    KC_N, KC_M,    KC_O,    KC_P,
    _______,  _______, _______, SYM,    KC_SPC, _______, _______, _______, NAV,  _______, _______, _______
  ),

  [_NAV] = LAYOUT_ortho_4x12(
    _______, _______, _______, _______, _______, _______, _______, KC_6,    KC_7,    KC_8,    KC_9,     KC_0,
    KC_ESC,  _______, _______, _______, KC_TAB,  _______, _______, KC_LEFT, KC_DOWN, KC_UP,   KC_RIGHT, KC_DEL,
    KC_LCTL, KC_LALT, KC_LSFT, KC_LGUI, _______, _______, _______, KC_HOME, KC_PGDN, KC_PGUP, KC_END,   _______,
    _______, _______, _______, FUN,     _______, _______, _______, GAME,    _______, _______, _______,  _______
  ),

  [_SYM] = LAYOUT_ortho_4x12(
    KC_EXLM, KC_AT,   KC_HASH, KC_DLR,  KC_PERC, _______, _______, KC_PLUS, KC_7, KC_8,    KC_9,    KC_EQL,
    KC_TILD, KC_GRV,  KC_SCLN, KC_PIPE, KC_CIRC, _______, _______, KC_MINS, KC_4, KC_5,    KC_6,    KC_DOT,
    KC_LCTL, KC_LALT, KC_LSFT, KC_LGUI, KC_AMPR, _______, _______, KC_ASTR, KC_1, KC_2,    KC_3,    KC_SLSH,
    _______, _______, _______, _______, MSE,     _______, _______, _______, KC_0, _______, _______, _______
  ),

  [_FUN] = LAYOUT_ortho_4x12(
    _______, KC_VOLD, KC_MUTE, KC_VOLU, KC_BRIU, _______, _______, KC_F12,  KC_F7,   KC_F8,   KC_F9,   _______,
    _______, KC_MPRV, KC_MPLY, KC_MNXT, KC_BRID, _______, _______, KC_F11,  KC_F4,   KC_F5,   KC_F6,   _______,
    KC_LCTL, KC_LALT, KC_LSFT, KC_LGUI, KC_PSCR, _______, _______, KC_F10,  KC_F1,   KC_F2,   KC_F3,   _______,
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______
  ),
};
