#!/usr/bin/env bb
(require '[babashka.deps :as deps])
(deps/add-deps '{:deps {io.github.rinx/sbar-bb {:git/sha "97aa02b85fa00dea557f135ad44e61551f43e8cf"}}})
(ns item.spaces
  (:require [babashka.process :refer [shell]]
            [clojure.string :as string]
            [sketchybar.core :as sketchybar]
            [config]
            [clojure.edn :as edn]
            [taoensso.timbre :as log]))

(defn extract-key [text]
  (string/replace text #" \|.*" ""))

(defn get-monitors [] (map extract-key (string/split (:out (shell {:out :string :err :string :continue true} "aerospace list-monitors")) #"\n")))

(defn get-workspaces [monitor]
  (string/split (:out (shell {:out :string :err :string :continue true} "aerospace list-workspaces --monitor" monitor)) #"\n"))

(defn extract-app-name [process]
  (if (or (nil? process) (= 0 (count process))) ""
      (let [name-dirty (re-find #"\| .*? \|" process)]
        (re-find #"\w[\w\s]*\w" name-dirty))))

(defn get-apps [space]
  (map extract-app-name (string/split (:out (shell {:out :string :err :string :continue true} "aerospace list-windows --workspace" space)) #"\n")))

(defn space-key [space]
  (str "space." space))

(defn add-space [space monitor]
  (sketchybar/exec
   (sketchybar/add-item (space-key space) :left)
   (sketchybar/set (space-key space) (conj config/item {:icon (string/upper-case space)
                                                        :icon.font (config/label-font :weight "Bold" :size 16.0)
                                                        :display monitor
                                                        :label.font (config/icon-font)

                                                        :icon.highlight_color (:text-dark config/colors)
                                                        :label.highlight_color (:text-dark config/colors)

                                                        :label.padding_left 4
                                                        :script (str config/plugin-dir "/space.clj")}))
   (sketchybar/subscribe (space-key space) "mouse.clicked")
   (sketchybar/subscribe (space-key space) "space_windows_change")
   (sketchybar/subscribe (space-key space) "aerospace_workspace_change")))

(defn add-custom-events []
  (sketchybar/exec
   (sketchybar/add-event "aerospace_workspace_change")))

(def app-icons (edn/read-string (slurp (str (System/getProperty "user.home") "/.config/sketchybar/icon_map.edn"))))

(defn get-icon [app] (let [icon (get app-icons app)] (if (nil? icon) ":default:" icon)))

(defn build-icon-strip [apps]
  (if (or (nil? apps) (empty? apps) (every? empty? apps)) "—" (string/join " " (map get-icon apps))))

(defn update-icons [space-key icons]
  (sketchybar/exec (sketchybar/set space-key {:label icons})))

(defn setup []
  (doseq [monitor (get-monitors)]
    (doseq [workspace (get-workspaces monitor)]
      (log/debug (str "setting up " workspace "/" monitor))
      (add-custom-events)
      (add-space workspace monitor)
      (update-icons (space-key workspace) (build-icon-strip (get-apps workspace))))))

(setup)
