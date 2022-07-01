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
  _GAME,
  _GAME_NUM,
  _NUM,
  _SYM,
  _NAV
};

// Homerow mods
#define LGUI_A MT(MOD_LGUI, KC_A)
#define LALT_S MT(MOD_LALT, KC_S)
#define LCTL_D MT(MOD_LCTL, KC_D)
#define LSFT_F MT(MOD_LSFT, KC_F)
#define RSFT_J MT(MOD_RSFT, KC_J)
#define RCTL_K MT(MOD_RCTL, KC_K)
#define RALT_L MT(MOD_RALT, KC_L)
#define RGUI_P MT(MOD_RGUI, KC_P)

#define LGUI_F5 MT(MOD_LGUI, KC_F5)
#define LALT_F6 MT(MOD_LALT, KC_F6)
#define LCTL_F7 MT(MOD_LCTL, KC_F7)
#define LSFT_F8 MT(MOD_LSFT, KC_F8)
#define RSFT_4 MT(MOD_RSFT, KC_4)
#define RCTL_5 MT(MOD_RCTL, KC_5)
#define RALT_6 MT(MOD_RALT, KC_6)
#define RGUI_0 MT(MOD_RGUI, KC_0)

#define LGUI_LABK MT(MOD_LGUI, KC_LABK)
#define LALT_LCBR MT(MOD_LALT, KC_LCBR)
#define LCTL_LBRC MT(MOD_LCTL, KC_LBRC)
#define LSFT_LPRN MT(MOD_LSFT, KC_LPRN)
#define RSFT_RPRN MT(MOD_RSFT, KC_RPRN)
#define RCTL_RBRC MT(MOD_RCTL, KC_RBRC)
#define RALT_RCBR MT(MOD_RALT, KC_RCBR)
#define RGUI_RABK MT(MOD_RGUI, KC_RABK)

#define LALT_MPRV MT(MOD_LALT, KC_MPRV)
#define LCTL_MPLY MT(MOD_LCTL, KC_MPLY)
#define LSFT_MNXT MT(MOD_LSFT, KC_MNXT)

// Thumbs
#define SYM_ENT LT(_SYM, KC_ENT)
#define NUM_ESC LT(_NUM, KC_ESC)
#define GAME_NUM_ESC LT(_GAME_NUM, KC_ESC)
#define NAV_TAB LT(_NAV, KC_TAB)
#define GAME TG(_GAME)

// Other
#define LALT_Z MT(MOD_LALT, KC_Z)

// Mod-tap does not work with shifted keycodes
bool process_record_user(uint16_t keycode, keyrecord_t *record) {
    switch (keycode) {
        case LGUI_LABK:
            if (record->tap.count && record->event.pressed) {
                tap_code16(KC_LABK);
                return false;
            }
            break;
        case LALT_LCBR:
            if (record->tap.count && record->event.pressed) {
                tap_code16(KC_LCBR);
                return false;
            }
            break;
        case LSFT_LPRN:
            if (record->tap.count && record->event.pressed) {
                tap_code16(KC_LPRN);
                return false;
            }
            break;
        case RSFT_RPRN:
            if (record->tap.count && record->event.pressed) {
                tap_code16(KC_RPRN);
                return false;
            }
            break;
        case RALT_RCBR:
            if (record->tap.count && record->event.pressed) {
                tap_code16(KC_RCBR);
                return false;
            }
            break;
        case RGUI_RABK:
            if (record->tap.count && record->event.pressed) {
                tap_code16(KC_RABK);
                return false;
            }
            break;
    }
    return true;
}

// Keymap
const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
  [_BASE] = LAYOUT_ortho_4x12(
    KC_Q,    KC_W,    KC_E,    KC_R,    KC_T,   _______, _______, KC_Y,    KC_U,    KC_I,    KC_O,    KC_BSPC,
    LGUI_A,  LALT_S,  LCTL_D,  LSFT_F,  KC_G,   _______, _______, KC_H,    RSFT_J,  RCTL_K,  RALT_L,  RGUI_P,
    KC_Z,    KC_X,    KC_C,    KC_V,    KC_B,   _______, _______, KC_N,    KC_M,    KC_COMM, KC_DOT,  KC_SLSH,
    _______, _______, _______, NUM_ESC, KC_SPC, _______, _______, SYM_ENT, NAV_TAB, _______, _______, RESET
  ),

  [_GAME] = LAYOUT_ortho_4x12(
    KC_TAB,  KC_Q,    KC_W,    KC_E,         KC_R,    _______, _______, KC_T,    KC_Y,    KC_U,    KC_I,    KC_O,
    KC_LCTL, KC_A,    KC_S,    KC_D,         KC_F,    _______, _______, KC_G,    KC_H,    KC_J,    KC_K,    KC_L,
    KC_LSFT, LALT_Z,  KC_X,    KC_C,         KC_V,    _______, _______, KC_B,    KC_N,    KC_M,    KC_P,    KC_SLSH,
    _______, _______, _______, GAME_NUM_ESC, _______, _______, _______, _______, _______, _______, _______, _______
  ),

  [_GAME_NUM] = LAYOUT_ortho_4x12(
    _______, KC_1,     KC_2,    KC_3,    KC_4,    _______, _______, _______, KC_F1,   KC_F2,   KC_F3,   KC_F4,
    _______, KC_5,     KC_6,    KC_7,    KC_8,    _______, _______, _______, KC_F5,   KC_F6,   KC_F7,   KC_F8,
    _______, MOD_LALT, XXXXXXX, KC_9,    KC_0,    _______, _______, _______, KC_F9,   KC_F10,  KC_F11,  KC_F12,
    _______, _______,  _______, _______, _______, _______, _______, _______, _______, _______, _______, _______
  ),

  [_NUM] = LAYOUT_ortho_4x12(
    KC_F1,   KC_F2,   KC_F3,   KC_F4,   _______, _______, _______, KC_PLUS, KC_7,    KC_8,    KC_9,    KC_ASTR,
    LGUI_F5, LALT_F6, LCTL_F7, LSFT_F8, _______, _______, _______, KC_MINS, RSFT_4,  RCTL_5,  RALT_6,  RGUI_0,
    KC_F9,   KC_F10,  KC_F11,  KC_F12,  _______, _______, _______, KC_DOT,  KC_1,    KC_2,    KC_3,    KC_SLSH,
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______
  ),

  [_SYM] = LAYOUT_ortho_4x12(
    KC_EXLM,   KC_AT,     KC_HASH,   KC_DLR,    KC_PERC,   _______, _______, KC_CIRC, KC_AMPR,   KC_ASTR,   KC_EQL,    KC_QUES,
    LGUI_LABK, LALT_LCBR, LCTL_LBRC, LSFT_LPRN, KC_MINS,   _______, _______, KC_PLUS, RSFT_RPRN, RCTL_RBRC, RALT_RCBR, RGUI_RABK,
    KC_SLSH,   KC_GRV,    KC_DQUO,   KC_QUOT,   KC_UNDS,   _______, _______, KC_TILD, KC_PIPE,   KC_SCLN,   KC_COLN,   KC_BSLS,
    _______,   _______,   _______,   _______,   CAPS_WORD, _______, _______, _______, _______,   _______,   _______,   _______
  ),

  [_NAV] = LAYOUT_ortho_4x12(
    KC_PSCR, KC_VOLD,   KC_MUTE,   KC_VOLU,   KC_BRIU, _______, _______, _______, _______, _______, _______,  KC_DEL,
    KC_LGUI, LALT_MPRV, LCTL_MPLY, LSFT_MNXT, KC_BRID, _______, _______, KC_LEFT, KC_DOWN, KC_UP,   KC_RIGHT, KC_INS,
    _______, _______,   _______,   _______,   _______, _______, _______, KC_HOME, KC_PGDN, KC_PGUP, KC_END,   _______,
    _______, _______,   _______,   GAME,      _______, _______, _______, _______, _______, _______, _______,  _______
  ),
};
